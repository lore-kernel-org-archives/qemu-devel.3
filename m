Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A197DC531CC
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 07:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wntW6-00044d-Rv; Sun, 26 Jul 2026 03:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <caojunze424@gmail.com>)
 id 1wntW5-00044M-6a
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 03:43:21 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <caojunze424@gmail.com>)
 id 1wntW3-0004kd-I7
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 03:43:20 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2cf110997efso4177615ad.2
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 00:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785051798; x=1785656598; darn=nongnu.org;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=b9KU7z4y4buiVrgRcV1hklRK/bdxHz8ig1mbBaIdLeQ=;
 b=UC3RfyjqCT9ZDU0bgzS8mpTAnnMCO1n64ZpdV1bkzk6O/QfzoMC/HrYDIbd44R/kK+
 8WWONbtLO5QkCZeBF5qyMKF2FML/BJfkvz3mvs4uea9MeatH86itNznD8VoToEM2IbR1
 IJAsGpkST5UZynQEv4Hw2NAUfe9OeljH8Fy9FKYKo8l6j/FCtvpP6oZpARfuDdZqml7P
 KiQI/a+cNMG3QJ3jFetYtPo/1zt9tExoCRvt5h5LE3OW/aNrawyfS8rst22LSwXumUDB
 l1gBL5LPu6gOfMAfVUSL/PdddSFYXxiNEDXXHgQ+mVc4YnsWp/IEPx81zpc7TrB2EBYh
 i/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785051798; x=1785656598;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=b9KU7z4y4buiVrgRcV1hklRK/bdxHz8ig1mbBaIdLeQ=;
 b=R7noAfSg73oL/FZdgcsDFfkOvd7yEY+6HcSUkp8F0owF4SlAA26+An0m/ScfAOf+mD
 u7N/1vFUUvTzWblLQuJXkNwYmx3Fa9oURWyqhdUo0qzhBwQ63oMiXlidC3FShsTZgScZ
 Eki364zeUe7V8jHSM0YfZ4UT6yG28pAZHXqAMaBBqgL3i4ewdpQNye7b/j8fkSQTq3/p
 SXwaInu+XDjXb8sJEifp1BY8P4NBtUangV0LlY4bjeXn7fcBEWYg0RsnAzMBZiZ8wLBc
 lXWFr73pk9tokx3vZZStfqMb6VDGSFdSy4lBY+ViA1twa+Y7GvOFu2BYsmEUTshLNozD
 C67A==
X-Gm-Message-State: AOJu0YwqCodsEwi2nAwWb0p8iaeRf74DNDt3lkPs8PaE11aw9dO4gTDL
 7eXwnfoP6Qcfo/V5j6ByI/FZ1NnTOo9K4WXgDtREPBbEKlqKMXOY/WPG
X-Gm-Gg: AR+sD11jjq37zpC8nr+u7U0Lk5be+Z2LO8Z2k6kTfx12Mto86hWPT41vz/wyjzsf7ye
 ZbsMbn25UGLd0ZaQMxXpjHgOXxo3Oa2pN7Xhux3oCo6Ky/tyDejozyoS0Y/Cu1gk5gYNoVwF8L4
 zGk8Rg/BOC+hJzSdPkKgPwZe5NP6CbC6MXV3gqb3SwWRz8j7BPjzgiRmk8p81leBsJeDUy1Y6wR
 geJUVn25R9KLwPeCglU4BM2GQmD+LciOy1G3BfXBFMFqmZkBLv1DlLidV9M42nZa8bcllIaXiQz
 Kh13PC/jNM05tjo47hn6HBzWUJH7RwIVcUnEv5iV5R+/DcC+QXgfpAYr9WRNa0nHi27zbfAmg57
 RqqE5WxHLtkPJ+We3RO19KugdIyAvc/rGxdGdQPfgMPUSjlCJJNCyDNVDu7BLaXIP39olCHdtIO
 3vgmXTaG/h5IrzIMH77JSm
X-Received: by 2002:a17:903:390c:b0:2c9:fbde:ab68 with SMTP id
 d9443c01a7336-2cfde844f2bmr58129325ad.3.1785051797884; 
 Sun, 26 Jul 2026 00:43:17 -0700 (PDT)
Received: from DESKTOP-7HME356.localdomain ([38.34.7.236])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc548e63sm18236602eec.19.2026.07.26.00.43.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 00:43:17 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5/7] hw/riscv: k230: add decomp gzip in K230 board
From: Junze Cao <caojunze424@gmail.com>
To: Tao Ding <dingtao0430@163.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu@processmission.com, farosas@suse.de, lvivier@redhat.com
In-Reply-To: <20260721161335.73872-6-dingtao0430@163.com>
References: <20260721161335.73872-1-dingtao0430@163.com>
 <20260721161335.73872-6-dingtao0430@163.com>
Date: Sun, 26 Jul 2026 15:43:12 +0800
Message-Id: <178505179207.940286.1406120293278713894.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785051795; l=681;
 i=caojunze424@gmail.com; s=junze-gmail; h=from:subject:message-id;
 bh=Y5S6DlMXNN8pl1AoHZnUuI7INPc9wZud/rupcev/3Rs=;
 b=5z7ih+Aeci4FPuUU04aRDEFMgtxG+gmmsviP1d43oWTCr0IWgY+XJs+CkK+KTApw+Qb1ZLl8h
 l4TjOQaBBIKCJ1J2eooX+PaWnoulavGjOI+t0mChgaduhdJ9jfD/Pw1
X-Developer-Key: i=caojunze424@gmail.com; a=ed25519;
 pk=lnFIWNw+6CoDrHFIKUJKdgrRbvgAbQGcEFiVsIigOJ8=
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=caojunze424@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 22 Jul 2026 00:13:33 +0800, Tao Ding <dingtao0430@163.com> wrote:
> diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
> index 156a386edc..a12d36965a 100644
> --- a/include/hw/riscv/k230.h
> +++ b/include/hw/riscv/k230.h
> @@ -35,6 +36,7 @@ typedef struct K230SoCState {
>  
>      K230WdtState wdt[2];
>      K230GSDMAState gsdma;
> +    K230DecompGzipState decomp_gzip;
>      MemoryRegion sram;
>      MemoryRegion bootrom;
>  

Please disregard the Reviewed-by tag in my previous reply; it used an
obsolete identity. The review itself is unchanged.

Reviewed-by: Junze Cao <caojunze424@gmail.com>

-- 
Junze Cao <caojunze424@gmail.com>


