Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D97C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 00:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb80F-0002QT-JU; Mon, 05 Aug 2024 20:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sb80E-0002Pq-Ov
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 20:24:38 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sb80C-00006V-St
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 20:24:38 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-70d28023accso12244b3a.0
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 17:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722903874; x=1723508674; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nvNBnlCgKLuYQk6alhTWp/Y95e3DS4DVGNupKrD7uV8=;
 b=ky3Jad8nJJlO6PY6/IHTWH5DYN0PzAmJsoM+4M9/bICx520M3chEFCVDYwxVL5PtTn
 e4IcbC4pofF9lbEHiwpahgf0CwsNzzAkqbWUe/H5JemeJyhLJHsVGPXf2oTJ58e8NRgf
 9tarWHQKKIHvH3s+Fwid2gdiSwxQynaZtt3in3d2Mhb7rJygLNz5UswZM5KWraRDI/EC
 p7bT/2PSDlcIzWYAunwo5E8P53XgYW43HTjV1C9hdvWA27o3D+Jxm4p4fV3TueVz3rbm
 KxHEfHwMcGdAno+vDZ80H2v8AjTUAEIXxvlsXt/BRVeIHVuIbIgc1hBzvAHMS0FWO6sN
 BfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722903874; x=1723508674;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nvNBnlCgKLuYQk6alhTWp/Y95e3DS4DVGNupKrD7uV8=;
 b=TCg4VDb/RSyX50DLvIi1RuW/HzEYVBKYCmTinMdyPRLQD+pDZ8Fkrxl/a9OYXox4zj
 3NkOWl5xhHFgCZsvpze7pBUijAtoo2/HFFWByfseu+XWuZ1xOeSmVzjUGNhSbXCVysXw
 UBwxkj2dKbpswtrjnQCZcItrKkgUbutV4o/GKOLWbL++ylgNm045aGs8NpNEu5k9y82e
 E0cMN4bbfGEp5DmBXxgieGbPtQ09qSlc5ThtG3fLYrhU6zWMt5obZ20V4RJeKVp3FFCq
 Lty7uWSJ/Vz2VB1SyyENs+pcxNXIDnGS+DHsAfmxUZphaQq32rI/PdrAaIZajhBtGCkj
 9opA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrKGKCcwvNMjEfgW4AElayjnlIXAUwiaUeZnd7xLvpi47JktCW+dZvzUuBfB52Zc9Q2GJtqOJ/7O/1YHhHRqyAG+5u6aU=
X-Gm-Message-State: AOJu0Yx+LFpRfkxNtpDqkRDg1fEENwnKFWHlmInDl6jGS3v8AchhDpfH
 98lxO2N3zI9ErbkOTf6/1qPdht5GT8UhVfQSUKfaumIQnJ/cv70t
X-Google-Smtp-Source: AGHT+IGFzq61kqaip43YQ3FBKsA8fOImhVOuGEwklfOQkXmltXW3tBTrcZoGIbnO1pDKrVOq1d409A==
X-Received: by 2002:a05:6a21:7881:b0:1c0:f5fa:db10 with SMTP id
 adf61e73a8af0-1c699438e39mr15257591637.0.1722903874366; 
 Mon, 05 Aug 2024 17:24:34 -0700 (PDT)
Received: from [192.168.0.22] ([210.223.46.112])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff5905f9b9sm74225545ad.130.2024.08.05.17.24.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Aug 2024 17:24:33 -0700 (PDT)
Message-ID: <0309f17d-9355-4414-9af4-e7af8528ecf2@gmail.com>
Date: Tue, 6 Aug 2024 09:24:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ufs: add basic info of query response upiu
To: Minwoo Im <minwoo.im@samsung.com>, Kyoungrul Kim <k831.kim@samsung.com>
Cc: Jeuk Kim <jeuk20.kim@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 SSDR Gost Dev <gost.dev@samsung.com>
References: <CGME20240802051902epcms2p319bc095a15eaef8de4e6955f6718371d@epcms2p3>
 <20240802051902epcms2p319bc095a15eaef8de4e6955f6718371d@epcms2p3>
 <Zq7PC4rOstnYhzwf@localhost>
Content-Language: ko
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <Zq7PC4rOstnYhzwf@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pf1-x435.google.com
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

On 8/4/2024 9:44 AM, Minwoo Im wrote:
> On 08/02, Kyoungrul Kim wrote:
>> Modify to fill the opcode, idn, index, selector information of
>> all Query Response UPIU. because attr and flag operation of query
>> response upiu need these information too.
>>
>> Signed-off-by: KyoungrulKim <k831.kim@samsung.com>
> Reviewed-by: Minwoo Im <minwoo.im@samsung.com>
>

Thank you for your contribution.


Reviewed-by:Jeuk Kim <jeuk20.kim@samsung.com>


