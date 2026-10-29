Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3332606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 11:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WWhnsHOJ;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=o3Dnx1wz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMOmo-0008M1-SI; Thu, 29 Oct 2026 07:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seott@redhat.com>) id 1xMMsx-0000hg-JL
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 05:57:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seott@redhat.com>) id 1xMMsv-0000i8-Vh
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 05:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793267844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dKAG+ubY1efSPUYqRkc5qEyTI2Q2ES4PrGzlP4BhHMI=;
 b=WWhnsHOJoGEcdqNGNYkmD/evkj76fkBaEfE5k/KP+ZtscNxxLVZUuymz1Cll8N5EIH6Oyt
 oFHyzksFCUonJ2H1yKwLuvAmc1GO78ntiYFN7vGa5wh5ti58hCVtIhs3H8pyPPW7Ha6bRk
 4fAhyipnRBQ2QJnBL1JUqbhxw+Q9Idc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-K6G_eWgTO8mVsiMqj3okhg-1; Thu, 29 Oct 2026 05:56:15 -0400
X-MC-Unique: K6G_eWgTO8mVsiMqj3okhg-1
X-Mimecast-MFC-AGG-ID: K6G_eWgTO8mVsiMqj3okhg_1793267774
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48e1291432aso1439616f8f.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 02:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793267774; x=1793872574; darn=nongnu.org;
 h=content-type:mime-version:references:message-id:in-reply-to:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dKAG+ubY1efSPUYqRkc5qEyTI2Q2ES4PrGzlP4BhHMI=;
 b=o3Dnx1wzIQLhZGkawUccZJmKeFvQPERdok6YbDN2q/szWgTetNen6vMRzQcla/QWan
 V4kn+xFX2fyxnLwL6B1cE1EesRh3aKGudAM+D1SmmzRIDjW7zRL1Eb/TTfeRZqs2dwig
 LicPfMCh481MsZdtJRs9F7ENu0xkUH5zxwhrRc24elpQso+j6lRVtpRfUo0DR+UcL8+P
 qbfNZbnqsoeuHOXBjLau9NQ0PRzrUfB60VaRlHh61gvGLsKhIX3eAikygWApgoqxtVMg
 VCpHbLV7NCSlJaMu7K0+YWFfTY+l+g0vbvRyeeoUmAmkR2F4gKXpecRB70r+591hnw20
 LTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793267774; x=1793872574;
 h=content-type:mime-version:references:message-id:in-reply-to:subject
 :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dKAG+ubY1efSPUYqRkc5qEyTI2Q2ES4PrGzlP4BhHMI=;
 b=Xj8wulnuRITu4lVb5dzA/3o0aHNV62/QmWqJUQ44M0dREWyIOztRMs4zud8uX1Wdit
 EAqW8omJcW/5maZciPxsbdiZCxLNIyhjfL5jPC6U7nQz6SQJ9i8mU1w1saSNKFeffda6
 Qt60OPrDWNCC5CUsSav7xixgOLG7zAbK6WlpfON6MQoDh8H5zkWz6pAena/v77Mkv2Oo
 msE8nqOznYsn+LBFtmscnGw8TB+5qfmW2Ur34e6tdvB9Q436uTb0jRhDNe2qt4A/te61
 R/D1ZWe5yt79NvID4AdCf1s7nvLuTvhKUB/nnUK9Tzgkk1OvH8F0lRxcUk5z8Nx8ayvx
 5vNQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwIP3aAu84nYgCh7JScJdBgWLoW4+tbh5+v4/XWoC+f4PcqTbblvQ3tX/C4nO8ZO7Er0F9UBmi5ij7k@nongnu.org
X-Gm-Message-State: AFq9FYL/oXy0OMhW0zSVxuQ8PLFw9fXT9xZweAcrXZntmr7t5Iba1r4Y
 9IlNvKzyBTi+StkttgjcmrHRYh5WKWWIheSfbpUdncekLkywfObwaGk5irXtO1/kJANa9A00tY3
 Zx2d8HnfOJ4jTfwTdnHVAVIdcf4dkCzaSZ0rWQtGqIazIjHxhne1O+Nj9
X-Gm-Gg: AYBFou1YTfL+jl0JzbLE2l2vJKKT5wOaIuSNlcSYHb05hLonHBFGQP6Rwu0SSyYaNyI
 5XI8ktbMMZPSwK0g82gIVbn2nfZCUQ8LS02bo6jAt/VZPmCTNkMbryN5n52KAtFeZZ3hyt+hlNT
 I5aK+A5uAJIX6Mxcuc4Zhgf9tJBl1n5r2HnrvrXpA7nE593BLYveBxx/mLI/MjnNPVaY+EGRB5w
 M1nXNOI59GOaULK4/Co73Ob4CJGmmPIGDhDRAknNFFgmXTMPj9KRTXV5yx8cIWdLQmwOQAwvs+u
 7o3j7QPbb9OKWNGSZ2b3/y74UNPk5zD0VIu14t+wKFyxY3qoCyxdBs4kaLF3o9oswx3Phod2oT/
 xFBcGiZVxFWxpE3msn4jSWfm3PLgtmdYaCYsP8o1VksYBR/JzwYq05nCWz37eXTaLoRv7sttdoT
 rNGVUHCkYhCyxl2xD8FCjh4BaGFH68jG1G7WHMd5s=
X-Received: by 2002:adf:ec49:0:b0:48e:1f08:4f05 with SMTP id
 ffacd0b85a97d-48e5d5d0998mr8591626f8f.33.1793267774267; 
 Thu, 29 Oct 2026 02:56:14 -0700 (PDT)
X-Received: by 2002:adf:ec49:0:b0:48e:1f08:4f05 with SMTP id
 ffacd0b85a97d-48e5d5d0998mr8591577f8f.33.1793267773903; 
 Thu, 29 Oct 2026 02:56:13 -0700 (PDT)
Received: from seott-rh (p200300f6af1574019b2c5947d8ec139e.dip0.t-ipconnect.de.
 [2003:f6:af15:7401:9b2c:5947:d8ec:139e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4806e208sm27588138f8f.40.2026.10.29.02.56.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 02:56:13 -0700 (PDT)
Date: Thu, 29 Oct 2026 10:55:37 +0100 (CET)
From: Sebastian Ott <seott@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 peter.maydell@linaro.org, shaju.abraham@nutanix.com, 
 khushit.shah@nutanix.com, richard.henderson@linaro.org, 
 pbonzini@redhat.com, skolothumtho@nvidia.com, philmd@oss.qualcomm.com, 
 7746591750@163.com, maobibo@loongson.cn, harshpb@linux.ibm.com, 
 amachhiw@linux.ibm.com, daniel.barboza@oss.qualcomm.com, 
 milesg@linux.ibm.com, farman@linux.ibm.com, cohuck@redhat.com, 
 armbru@redhat.com, mbawa@redhat.com
Subject: Re: [PATCH for-11.2 2/9] target/arm: Move REVIDR into isar.idregs[]
 storage
In-Reply-To: <20261029092307.281287-3-eric.auger@redhat.com>
Message-ID: <8e4a253b-aae1-7fff-6273-d95f32976954@redhat.com>
References: <20261029092307.281287-1-eric.auger@redhat.com>
 <20261029092307.281287-3-eric.auger@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=170.10.129.124; envelope-from=seott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:59:08 -0400
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On Thu, 29 Oct 2026, Eric Auger wrote:
> Move REVIDR into the isar.idregs[] array as other ID registers.
> This will allow to overwrite it as others.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Suggested-by: Khushit Shah <khushit.shah@nutanix.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Sebastian Ott <sebott@redhat.com>


