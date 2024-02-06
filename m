Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389D9C48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 15:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXN9i-00057A-Uc; Tue, 06 Feb 2024 10:14:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rXN9h-00056p-SD
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 10:14:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rXN9g-0004ao-Gs
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 10:14:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707232475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Ezl4Dqld4PLMxNC7ep4rHIJ7nvB/U7YfxaO1RYrLR0=;
 b=G+5t9DTGupoppvfGQmVwPKIFRfJOl0CKd5nBNZlanUDSb7xfvB9jNC+R8Z7GDpDscf7xEM
 JC7DQ5ySrcSxhTTszbzNxm8gMiXigUN8qc5GJEpbjA6k9vvwg2FTKusPR1RWEVDWUQRHn8
 iuAuHaH+xfSsTEVU+bOsFSGO434gd9o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-nQHUfKXXMB-KykaLlgPg9Q-1; Tue, 06 Feb 2024 10:14:33 -0500
X-MC-Unique: nQHUfKXXMB-KykaLlgPg9Q-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33b38ce055fso1213071f8f.1
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 07:14:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707232472; x=1707837272;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5Ezl4Dqld4PLMxNC7ep4rHIJ7nvB/U7YfxaO1RYrLR0=;
 b=Z4KLisjYzaabiArxqGcIub445tpEOw8pzQy2eQLOSVL5GpF5Qe183JcaCqBp3Z71jS
 Y593wHP3V1IkJQYIvgQxpm5fTSmMhie46I5ysztbZlcEfEWOoIueSgNtMpAj3XncGBr2
 66P38Yi8bQlC6d5hXjeHxcbir186ojfSOUZFmjNuhrEzlp1k8qvPUFyvIuRvQ2G4VaGR
 /admMv+0YN4fSgeGaT4wOnRlm+LU/IjoTW72FSxNeIKGO9eNRxCWYeDjI0xZif181MY4
 x3gjXqrfDjeMzD0DB+BIbjMBzTs145854GK4PgZp2dGmgNxSOdY4RdsZetgK5gaVKGL7
 HPdA==
X-Gm-Message-State: AOJu0YxIcciasVoYypknOWwUt8FyLrE7zp3+vOeJN5qJmY7iKNISRSk6
 aR6lUWWzZKDPR4MO1Q2zhlO4/AYPDQxzgzVRMQSToQ5aMATOQNWvwJDOtB+WRP0AFHBUMZmtsx/
 50mxJcJ8UPPEo0ry55RRodXU6mJgpH1jYxyEHJZkDJcuiHjTYAd8T
X-Received: by 2002:adf:f505:0:b0:33b:2897:9cde with SMTP id
 q5-20020adff505000000b0033b28979cdemr1625549wro.57.1707232472390; 
 Tue, 06 Feb 2024 07:14:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHG1J6FxZnznjXoamd1OB986bfuvPyAdSwAdERz0MVqe8GSyTUdit/QIIcXgUom/6iKmv0feA==
X-Received: by 2002:adf:f505:0:b0:33b:2897:9cde with SMTP id
 q5-20020adff505000000b0033b28979cdemr1625540wro.57.1707232472087; 
 Tue, 06 Feb 2024 07:14:32 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXiGeO0q/yjmnMKejogS7GCCYpa33CHLIbPxiBXTFl6NiakFqdyO+6s78LVQVyECkHEshneqZf/QDMV67fWo2MAYH5srDAE4V6WhJFHeJBvK0ZC+r0M6zHhVNK/Q3DuMfEohhT4sRAg
Received: from ?IPV6:2003:cf:d740:65ef:7c9f:a118:b826:ff5f?
 (p200300cfd74065ef7c9fa118b826ff5f.dip0.t-ipconnect.de.
 [2003:cf:d740:65ef:7c9f:a118:b826:ff5f])
 by smtp.gmail.com with ESMTPSA id
 b17-20020a5d40d1000000b0033ae7d768b2sm2314438wrq.117.2024.02.06.07.14.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 07:14:31 -0800 (PST)
Message-ID: <544dbc24-e532-4e31-9de1-ad965bcccaf2@redhat.com>
Date: Tue, 6 Feb 2024 16:14:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-blk: do not use C99 mixed declarations
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
References: <20240206140410.65650-1-stefanha@redhat.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20240206140410.65650-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 06.02.24 15:04, Stefan Hajnoczi wrote:
> QEMU's coding style generally forbids C99 mixed declarations.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   hw/block/virtio-blk.c | 25 ++++++++++++++-----------
>   1 file changed, 14 insertions(+), 11 deletions(-)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


