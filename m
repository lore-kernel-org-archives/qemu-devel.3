Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9B3606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DQFyiPjy;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=HyRC169H
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ4Q6-0008Nd-7r; Tue, 20 Oct 2026 03:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xJ4Q4-0008NT-S0
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 03:38:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xJ4Q2-0005F0-VS
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 03:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792481877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L4s5471ss6fbmaDIvPct2n1sGzHL/cPRd5fynIgNjcs=;
 b=DQFyiPjyi1EnYiO5ocikjGfTzCh1urf9x8+uZaHuhXinEEyHTcTUfL6eAkLU/JELcZ6GyT
 U30WWqX5BjaqOd5ROaAwQmtfosA/S4A4+8ch0pRD7YtarRBcPrKnuORFicu2vUeK3b53mb
 Lh1oMn17HkeGZhanzNJzUgM8tDJXUW8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-tC3CcxxpN4OOnV3DH3WTbw-1; Tue, 20 Oct 2026 07:37:55 +0000
X-MC-Unique: tC3CcxxpN4OOnV3DH3WTbw-1
X-Mimecast-MFC-AGG-ID: tC3CcxxpN4OOnV3DH3WTbw_1792481875
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48df5b058ddso1906351f8f.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 00:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792481874; x=1793086674; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L4s5471ss6fbmaDIvPct2n1sGzHL/cPRd5fynIgNjcs=;
 b=HyRC169HzL5Y8Vs12VougaLYxqL47lEgSYkWp6xjVM3sgtV+k/gPmNa8b6pDJOmJIj
 IkXLPfwlswimRA7/C1Ii2gswNvDZy/61xoqsOIU4TEdU+ExYiybqx4Umil8jOT5MtE3v
 BKkYSV+B69avXmRIrnQHti9tUeUbzn1HhKcQ1GPne96JUvNDVpPmpg2IMPm8t8eZr9Al
 JuN5HK0MSf/E5G2Bj4UoBYSCw9PcKmZ/Rt+y94g868BLl469XuT3kZARmh2W3gPB28go
 cCSkIHSbeWQePNa/nLSZjHmJggmbvMEkZUxBozNFmWbBqBw4OqdFxf6IUFxgKazcsDuw
 s2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792481874; x=1793086674;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L4s5471ss6fbmaDIvPct2n1sGzHL/cPRd5fynIgNjcs=;
 b=pcsAR37n5kcDQsrJqGFc6ZX9lezeIU9GPSGLAzhDNlk51X4GuS5e3iQe+cFB0M0qA6
 kafX3uOIhwoQRT4aAoFwup3VAsXiRxI34ShKnDLdjZSmjCV1hZ3aCCBgTdlqFe4Dte8G
 FgZGrynLaYEPw0Yz4BJxUu7nr/SYPsXDgu6cUtFY4J/msmFE3hqK2HP/a9OMI0ipLG03
 a/7PgJRM5bTRehS9bMF3ZuuGuWYq8GfwA1j8lEzsyL7uqL6uZIts5IAkyt7b5pgaVv0f
 rpHptyQWlXgaw87BSl8wt9mJkSaqOphwW/4uuPLtuZepaTWWIbg6Z9yjgaPPQ5Dhyrnx
 Q6Ow==
X-Gm-Message-State: AFq9FYKPZ940bcpASvBpKF4YXSVDmXw/GHo3XKsTzwBtkiWeOYWluP0X
 zjxF81kW0eFJlenj5w9Ybx62HUSUHXK6t7oNwWMZe3ES/0HQRemQOl6OqkokTNZsHSdyBLt3C+t
 D1/pyk2rrC85tZjE7dnVJSI3QWupeA4SEDmbT6JF4luRTM3mZU9zDXtVR
X-Gm-Gg: AYBFou3TCb3IFpFa3m51stu61HsqN4ovMqUr3Ec6zF+AOGzKyIbrvU3FxWqHnvFs/CP
 zg8n+vLjlsvyOv7hj/FOumS5EDjLYJ8VlEbyw6LjzuUIpQmAbRUy/7wRypJIU4LEvE8dfV3gNVb
 uGYE0S9CsU1JSzhdWP3gDplXNpud0XL3eb10DFYqKDq69UFP0Mc+CbcYdp/5van8TyCsb8n0YjO
 yin3vi4pwwXbIj2L4Y4bKaqhW+l6vLi08FKjpiRj3gZ2Af90hQpLI6HMlR1OWcnaF5Pbta46kda
 jbsHlzuB1lQs3PShzwYnWk/T58X+dH3+/NQ8HGDTKdOnB0ym6zU4FEeqNnAKIFvD965ZsA==
X-Received: by 2002:a05:6000:25c7:b0:48b:e54:84a1 with SMTP id
 ffacd0b85a97d-48e07fe813dmr21333451f8f.55.1792481874419; 
 Tue, 20 Oct 2026 00:37:54 -0700 (PDT)
X-Received: by 2002:a05:6000:25c7:b0:48b:e54:84a1 with SMTP id
 ffacd0b85a97d-48e07fe813dmr21333404f8f.55.1792481873895; 
 Tue, 20 Oct 2026 00:37:53 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d817f8dsm4161771f8f.23.2026.10.20.00.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 00:37:53 -0700 (PDT)
Date: Tue, 20 Oct 2026 03:37:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Nariman Sayed <narimansayed28@gmail.com>
Cc: qemu-devel@nongnu.org, Eugenio Perez Martin <eperezma@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Subject: Re: [PATCH v2 0/3] net/tap, virtio-net: auto-detect MTU from host
 tap device
Message-ID: <20261020033724-mutt-send-email-mst@kernel.org>
References: <20260816043451.2547-1-narimansayed28@gmail.com>
 <20261007050718.926-1-narimansayed28@gmail.com>
 <CACt+UE7HTzkeym-4GCy7YnzX=XM_zUBPE6Pbi71dPcCcTi6PLQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACt+UE7HTzkeym-4GCy7YnzX=XM_zUBPE6Pbi71dPcCcTi6PLQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 08:19:19AM +0300, Nariman Sayed wrote:
> Hi all,
> 
> Gentle ping on this series. v2 addresses Eugenio's feedback by adding
> a generic get_mtu callback to NetClientInfo, so virtio-net no longer
> checks the backend type.
> 
> Jason, Michael, could you please take a look when you have time?
> 
> Thanks,
> Nariman

Given Eugenio gave feedback on this one, I'd like his ack that
his comments have been addressed.


