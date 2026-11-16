Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77650606A339
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gbFF+5Kz;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Q3PZ4U2z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSweB-0003Mv-GE; Mon, 16 Nov 2026 08:21:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xSwe6-0003KB-Cw
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 08:21:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xSwe4-0008Qx-Tl
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 08:21:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794835275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Y4k32IW79ZH1tZuSI7GxpzyRLeQDo58xgr7jqO6rgco=;
 b=gbFF+5Kzpgygty0pPM6UpXGUQf5inBLFE/4d8C9+VG9z3QKiFXTSBkYl9at9Q0elRU14GM
 VhYLvtdz5wCoTgdrEyWNY/+OtF/xoYQh0gHE0mPdNfrBigm03Qdf+fBIqrkm5XPg3EKkEX
 G7m111JvslOqxM8zVVZH/z2ISR9Oyv0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-9XXGtZztNMuTgLuvJJ-hTw-1; Mon, 16 Nov 2026 08:21:13 -0500
X-MC-Unique: 9XXGtZztNMuTgLuvJJ-hTw-1
X-Mimecast-MFC-AGG-ID: 9XXGtZztNMuTgLuvJJ-hTw_1794835273
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4b0a307487aso16141705e9.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 05:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794835272; x=1795440072; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Y4k32IW79ZH1tZuSI7GxpzyRLeQDo58xgr7jqO6rgco=;
 b=Q3PZ4U2zpUW896Oi6Kw7cJI1a4GM9UygMRzvXncDtZafZaaMn2ntSqEe0QAB9lq1Gf
 aJIjNK52cW/jFjlkyK0CVgH5rfKshCzKSXmaay04hoe74Xq+zLpVrSsMls5Py6dIst60
 aBnwvfVQhoa8FGwH53czkTI4c2E2JhgtIC2sO1Odb6caa/PcwaEsz8Tez+7CZ5zFpika
 /dSwDlVq/8Ne4clvM68UsnBQL97+kxmmS0zYIzXZ8iCCCPnQERMxWi6J8DMJo35xzYiw
 UyCroFW1W0Te4qARrsALomqZyZFSRLEvzfe06C4Oz/psu+Yej0GI93fFyM42jA7DIPeE
 LEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794835272; x=1795440072;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y4k32IW79ZH1tZuSI7GxpzyRLeQDo58xgr7jqO6rgco=;
 b=DEer7/RiJPKgYbprNRksuG9SbYOdPQNm+OlkKLd3NMFpyILNaQGZ+Bx89ydnSsDMI8
 EoQlIwBaNXAnEm0h7esnLENKb/B5FxuLLMPrkBWp5FIGIMYEz621vL9A6u0aLYcliM+a
 2CKL2+VGrjE7kLP9Rd4Hw38IJqUq8LzZ4B5kx2FdP+QB/lQGZmcanFUlMIxsTzxEpJvl
 uEqtKXsG+a/1x3cc9r+Ao6NZuSfOvmg+r2JWGQ28863OoCtDL+RNurDxRThKS0BTwpqq
 ICc56HCtuZre0KnD7j28xkXSxteR0wnUSzbMbYURaWnF9EcVPC4VINugUukDtbeefxTT
 ikGw==
X-Forwarded-Encrypted: i=1;
 AL+hErFQYTTXEg48T3WBkG7hkBI1dcp+Zo5AKgjUGpPxuKkA9vOjIuRqE+RAVAm2dxU0Ytz9fxp/VwKbT/EF@nongnu.org
X-Gm-Message-State: APuU4Z/F/blt/V+PUb/Zasdx/o/1wZlUV3ujdmUil1h8OR+6zaXpbgt9
 HPiep+mZkuLZlfK7uolv64ULEKi8PPaNvmp8/sY0ubSTnciWE1rKy2g1WhLexk5HBaMuh/5MeBF
 dpRJ3O4d3OxZ5tmEiCkPRSFJRA7MvDpLk4z/HYXfzuHhQYqKUFlK1n3KE
X-Gm-Gg: AYBFou3NejvL4ccFct3HuzK/Mh+ZmToR2bi/jTL+L1mqN2reS449TW0xBgoAIs04VBL
 psHGUW4RlaBqBuHZp4DVdkwF/J6GC40aPKTGoqW2ke5y7J2BGzyVWqa13hZYQy5HwaUt8SXJ2jA
 hQZRumHCG9tjanCaoALJVa5dedwF9Mrtr2TrKQKDUqT0J19VcSwQ8wGiF4n+nqp/7mqmWsqfnQ9
 2Zf4+8OcPQUDOKFjypE3cQHwKqlAKxObyk9BDHwSiIxs1P3w21cNXoH4I/s2p+NPppwHN2F+pzi
 hw/SOB6Xd2qEAoTlwJcHdirjbxY+kZKHTRmdn0ebz/5JJJee7mQemzzr2DEwXySfqPWTJhbqA/u
 Ym4BriIMirNzfJHqdzbDrv/MI5vxvVqjWEsvTpjQbS8BbaA==
X-Received: by 2002:a05:600c:3509:b0:4a1:fc98:1cb1 with SMTP id
 5b1f17b1804b1-4bb55c5f579mr228015485e9.2.1794835272538; 
 Mon, 16 Nov 2026 05:21:12 -0800 (PST)
X-Received: by 2002:a05:600c:3509:b0:4a1:fc98:1cb1 with SMTP id
 5b1f17b1804b1-4bb55c5f579mr228014895e9.2.1794835272074; 
 Mon, 16 Nov 2026 05:21:12 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.75]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c609c8a77sm22564912f8f.49.2026.11.16.05.21.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 05:21:11 -0800 (PST)
Message-ID: <96329cae-05bf-4152-bd7f-e236fc5eb68a@redhat.com>
Date: Mon, 16 Nov 2026 14:21:10 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 24/26] hw: device AMD, Intel and ARM IOMMUs as secure
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20261113184254.2524253-1-berrange@redhat.com>
 <20261113184254.2524253-25-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20261113184254.2524253-25-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 13.11.26 um 19:42 schrieb Daniel P. Berrangé:
> These are needed in virtualization use cases to support PCI device
> assignment use cases so must provide a security boundary.
> 
> Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/arm/smmuv3.c       | 2 ++
>   hw/i386/amd_iommu.c   | 4 +++-
>   hw/i386/intel_iommu.c | 1 +
>   3 files changed, 6 insertions(+), 1 deletion(-)
Reviewed-by: Thomas Huth <thuth@redhat.com>


