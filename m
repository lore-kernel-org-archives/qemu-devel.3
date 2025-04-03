Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C21DAC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 11:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0IMO-00033h-VB; Thu, 03 Apr 2025 07:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1u0IMN-00033M-PY
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 07:03:47 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1u0IML-0001jN-SC
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 07:03:47 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-224191d92e4so7123675ad.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 04:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743678223; x=1744283023; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s2NiU9D56r5a/hZWDx/nyo2kOmHARw68d7gTpYCO7Pc=;
 b=DeYlUHBt3pihKssZsnL+hKHbcCHBED/LAOguceWVYQCGv5YoocAS1gB64EEZAWXKIA
 jdPtpsZChkzfhGr3il2Sa7Otdt08eVB8+Wyf2oHn09Mz3vP136tHlwADHMPl6g+p8TOC
 CKICvgOGPKYm2ttCU3zqh5DGPsczc2fr1kmJOio2Uh6E7CycGWOv8p4IbY8wrn1of+nq
 Q0i6HFr/5/h08NVaZh4tmPuucRHakYS0bnWts92FTcok386j8YaU3oJQvolboE9Q2dJu
 go8Jt/X61Slifrw7N224+f39+wSG5cf2jjug+hLE0gryTuPL7MWyn7lg4WLhZYQAbkvX
 2zDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743678223; x=1744283023;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s2NiU9D56r5a/hZWDx/nyo2kOmHARw68d7gTpYCO7Pc=;
 b=I7DWq1FVNiVIUd7kOj6EP/SMrM48ATW/c75yqUpfMSbDPcf1aGlIZ1a+XngAlXeNXs
 wcOTZLknQCcRFI9N3AjKMvjTB5vfo0ImIYB9iXbaALzNn6GBZ5fgIpRGbYxzJWxxOJnF
 SSBXJkSL3RIQXANvEoMkrUzWXdQu7JQH5AfgMX4+ypXeSbjBZnR2UCLuo9HZqCG3rM/Z
 0Bpot56XwoQXhVagULDCCdl3naUwLr8hodiNtxRFP8aCaneTSDw+qeuC8mHbuymI344X
 sfa2haME2VScZfM5n5n+g5TeAFRWMdi80q8p8smEi7xWPjLBMU7JvkmdeEhzzcQI8+ZL
 nMdQ==
X-Gm-Message-State: AOJu0YyE88oV8R7Mhtdu/O5MQgkTK5LsXrjUcRxQ5Xo5ATmdvtLTlnTz
 l57MKl8BBO7D8W4sHrJlAjaY90fEj1VDMMssmYKnKzZLMVQqRKyH
X-Gm-Gg: ASbGnct2PDTaeUqozy50F2jB+3xq3Xli3VdXp7KEfr+Y8Wfy0uEF1ZJvJdhkcHM1I/o
 76WJl2D1TZT261cXZbTX37kqanly5PxeRPjgzb/8cjb7YHvp8EpP7Scwg+lgh3Ed2M8q8pjU5i2
 EGlWE4K4upEaLc8sDnpz/TM4VSBJPj/wyAiqnTfyB/EmOFV28EQSviIBHd0VFHWrMFKvbCz87KC
 dy6kMr4CJH44H4fvwx69u40eUB8wosum1AcRWOcOG1BpemTh1GAYO82QAtiTT1zu4AWs2edQub4
 CheCKgkzOvLTyPLl/VPqeSHmEQbXZjGGdJry3LRlz/zaOti0gNQEjf6cq+o=
X-Google-Smtp-Source: AGHT+IH6aaCL1PzSiAalZrw5OfOcdKQqZGKE2XrYN/OYaWXJNrFi+RbhBLFzak5UM5Tgrq1MSZX6Sw==
X-Received: by 2002:a17:902:ced1:b0:21f:4b01:b978 with SMTP id
 d9443c01a7336-22977e1008bmr33724855ad.36.1743678223373; 
 Thu, 03 Apr 2025 04:03:43 -0700 (PDT)
Received: from [192.168.0.22] ([175.119.5.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785c994esm11576395ad.102.2025.04.03.04.03.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 04:03:42 -0700 (PDT)
Message-ID: <b031e5f1-0d7d-4094-9d85-aea603c88304@gmail.com>
Date: Thu, 3 Apr 2025 20:03:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ufs: Fix incorrect comment for segment_size and
 allocation_unit_size
Content-Language: ko
To: keosung.park@samsung.com, Jeuk Kim <jeuk20.kim@samsung.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <CGME20250403092140epcms2p355a7f039871b3e5b409754ef450b9158@epcms2p3>
 <20250403092140epcms2p355a7f039871b3e5b409754ef450b9158@epcms2p3>
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <20250403092140epcms2p355a7f039871b3e5b409754ef450b9158@epcms2p3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


2025-04-03 오후 6:21에 Keoseong Park 이(가) 쓴 글:
> The comments for segment_size and allocation_unit_size incorrectly
> described them as 4KB. According to the UFS specification,
> segment_size is expressed in units of 512 bytes.
> Given segment_size = 0x2000 (8192), the actual size is 4MB.
> Similarly, allocation_unit_size = 1 means 1 segment = 4MB.
>
> This patch updates the comments to reflect the correct size.
>
> Signed-off-by: Keoseong Park <keosung.park@samsung.com>
> ---
>   hw/ufs/ufs.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
> index ee13edacd8..542f13b10e 100644
> --- a/hw/ufs/ufs.c
> +++ b/hw/ufs/ufs.c
> @@ -1753,8 +1753,8 @@ static void ufs_init_hc(UfsHc *u)
>       u->geometry_desc.length = sizeof(GeometryDescriptor);
>       u->geometry_desc.descriptor_idn = UFS_QUERY_DESC_IDN_GEOMETRY;
>       u->geometry_desc.max_number_lu = (UFS_MAX_LUS == 32) ? 0x1 : 0x0;
> -    u->geometry_desc.segment_size = cpu_to_be32(0x2000); /* 4KB */
> -    u->geometry_desc.allocation_unit_size = 0x1; /* 4KB */
> +    u->geometry_desc.segment_size = cpu_to_be32(0x2000); /* 4MB: 8192 * 512B */
> +    u->geometry_desc.allocation_unit_size = 0x1; /* 4MB: 1 segment */
>       u->geometry_desc.min_addr_block_size = 0x8; /* 4KB */
>       u->geometry_desc.max_in_buffer_size = 0x8;
>       u->geometry_desc.max_out_buffer_size = 0x8;


Thank you for the commit!

Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>


