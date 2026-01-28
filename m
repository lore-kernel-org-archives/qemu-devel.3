Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22FF5D25B5A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 13:14:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl5Fp-00024O-EN; Wed, 28 Jan 2026 08:06:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vl5Fa-00020p-6w
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 08:06:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vl5FV-00044U-SG
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 08:06:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769605579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S+Cqsrs+um/8LodlhFAqbdDPNZMqrsyLaJ1XmEk7Wuc=;
 b=YCFcq6WfV8y1tg7GnA7s77RwVV2g+0o5+qMbO4leicSi304wjggvRI0q5TzknkLFbS5v9J
 Dqgz6q4ADgNNoyvTReWLY0gA2ZyJkAeBHy341UKVtnsToVydAdpq4tnH0JAD00dDtvMkbj
 wrqhjnEq5g2LSAqcmoVStTNsjZ5F+h8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-veG3be-XPxCJ4gOUWG46HQ-1; Wed, 28 Jan 2026 08:06:16 -0500
X-MC-Unique: veG3be-XPxCJ4gOUWG46HQ-1
X-Mimecast-MFC-AGG-ID: veG3be-XPxCJ4gOUWG46HQ_1769605575
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47d62cc05daso61984305e9.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 05:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769605575; x=1770210375; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S+Cqsrs+um/8LodlhFAqbdDPNZMqrsyLaJ1XmEk7Wuc=;
 b=ltduUB07Llc5WxRp9GWCln3GWgUhyTMa4kxTjhsL+YoOeMJIuMADxkq7WN2D7Rq4v2
 pDoo079JG92ucLpC71ptlitXHCbBo294f4OyZpUmKAPTmdG9AYdgTx5h4t9NTDfJ+AHK
 Ji1p4qoGedd8mHHgOrLC0doLGgmU/Sl6Ngl5MAt3LCb73A1zcD0P/F7CNvtUbg3PXhrY
 VJiRUBsvPBhJW/OxY/RUZhcFVaPRQuJP94M2ODZJqYyb8NOsp1/9uBtjJo2TJRwRvihX
 vukxwp+gkwgu3oCT4ZOrxdfLNwKYhb0uIBkjh18zTmcZio77yjVLEUim3twK5sKPisdf
 IZ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769605575; x=1770210375;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S+Cqsrs+um/8LodlhFAqbdDPNZMqrsyLaJ1XmEk7Wuc=;
 b=Ad0I9ZVu2Mnhzvvj61Js7LWGz/Zbdx1932rPuxEKfGPvSIIPYymxQe2tSitL7YWV3L
 B2lObZCg5k2nYWbb9FdMiAREPD4TxUUvkwOoCIRiUzlUAUWdIuPXZ91kFWIJ6RrT38Ql
 rM37Qm4TVTuMDbzkuKnqKUeutRmwqgESgPAoxBws7kF7cvZK5M7rwxi3COraiSnbXzm5
 N8+FqLFNjffK5tRoOdqWMqaNgZQmnP7vDCeLAix8IJ+c6cO6vMYl5zx+mjyM630C5xmO
 dSyDJOgqJfB85nhXVGZC5Ebh30gJmCnmXYaExPJgQLs6AvZ4v3vm36fruXhYFyvSFaYc
 HW9g==
X-Gm-Message-State: AOJu0YwvEn2SXwpLwXvQpXemltAal1KYnrw4Jycrzoioww9yD8QER/j2
 nV6DXbyD27FXuLWDvteU4Yjmk159QcMExIo1oChwyRo+O8sKVMOV8E7uux77gEAXtt83w9TyXoJ
 n6uhkTUVPbUehUA2DaJD84QD/U2RcVQYT/zfU8PdIj1Hr/qDQVE+TV+g+
X-Gm-Gg: AZuq6aKowBDnarfX4mWIOmEb7czCI9IZEql8sU65FZctz/OCspGB2GDWoWd1Pt06tx+
 a8oYQsJhTlp3RS78aBbM4n/0dWkyAG+BWe891kRmpBV3DYBYhtk2hvS1A3haaG8RfomERIRCi0E
 rL7d+f4S80IiKRtAEvdMRu5BSYVr66jtEzv3Phcq7wr3SFZzQDAfx2/arBN7vwapJpXtw7ynN6w
 pIOskdY2ee3KIvwgb3K/hpFU6365N5KKWwg/YPcpL/otifPpo+I5TN5vI+BVt49eZxu9t1rdkyl
 RQwP4qeQ5ArI7RlVY3TLCoXzoV88ERcsHHxNG/EG30kiPB2WtBesIz87n3QJPuXogA==
X-Received: by 2002:a05:600c:1381:b0:480:1e9e:f9b with SMTP id
 5b1f17b1804b1-48069c35120mr75284395e9.16.1769605575065; 
 Wed, 28 Jan 2026 05:06:15 -0800 (PST)
X-Received: by 2002:a05:600c:1381:b0:480:1e9e:f9b with SMTP id
 5b1f17b1804b1-48069c35120mr75283655e9.16.1769605574581; 
 Wed, 28 Jan 2026 05:06:14 -0800 (PST)
Received: from fedora ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806e2e5ffcsm6394125e9.18.2026.01.28.05.06.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 05:06:13 -0800 (PST)
Date: Wed, 28 Jan 2026 14:06:11 +0100
From: Juraj Marcin <jmarcin@redhat.com>
To: Stefano Brivio <sbrivio@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Laurent Vivier <laurent@vivier.eu>, 
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 0/4] migration: Pass network packets received during
 switchover to dest VM
Message-ID: <4uwcjd7ov7ib6q5pelqle3bdouoctyoqteec5f222cjatwkqxf@3p2n5hgjuwzk>
References: <20260127140316.4187221-1-jmarcin@redhat.com>
 <20260127192108.216495da@elisabeth>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127192108.216495da@elisabeth>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Stefano,

On 2026-01-27 19:21, Stefano Brivio wrote:
> [Cc'ing Laurent and David]
> 
> On Tue, 27 Jan 2026 15:03:06 +0100
> Juraj Marcin <jmarcin@redhat.com> wrote:
> 
> > During switchover there is a period during which both source and
> > destination side VMs are paused. During this period, all network packets
> > are still routed to the source side, but it will never process them.
> > Once the destination resumes, it is not aware of these packets and they
> > are lost. This can cause packet loss in unreliable protocols and
> > extended delays due to retransmission in reliable protocols.
> > 
> > This series resolves this problem by caching packets received once the
> > source VM pauses and then passing and injecting them on the destination
> > side. This feature is implemented in the last patch. The caching and
> > injecting is implemented using network filter interface and should work
> > with any backend with vhost=off, but only TAP network backend was
> > explicitly tested.
> 
> I haven't had a chance to try this change with passt(1) yet (the
> backend can be enabled using "-net passt" or by starting it
> separately).
> 
> Given that passt implements migration on its own (in deeper detail in
> some sense, as TCP connections are preserved if IP addresses match), I
> wonder if it this might affect or break it somehow.
> 
> Did you perhaps have some thoughts about that already?

I'm aware of passt migrating its state and passt-repair, but I also
haven't tested it as I couldn't get passt-repair to work. Does it also
handle other protocols, or just preserves TCP connections?

The main focus of this feature are protocols that cannot handle packet
loss on their own in environments where IP address is preserved (and
thus also TCP connections). So, mainly tap/bridge, with the idea that
other network backends could also benefit from it. However, if it causes
problems with other backends, I could limit it just to tap.

> 
> For context, we didn't really write comprehensive documentation about
> it yet, but:
> 
> - KubeVirt's enhancement repository has a detailed description at:
>   https://github.com/kubevirt/enhancements/blob/main/veps/sig-network/passt/passt-migration-proposal.md#live-migration-with-passt
> 
> - the QEMU-facing details are outlined in:
>   https://archives.passt.top/passt-dev/20241219111400.2352110-1-lvivier@redhat.com/
> 
> - usage of TCP_REPAIR is briefly described in passt-repair(1)
> 
> -- 
> Stefano
> 


