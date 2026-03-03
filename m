Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5975DEDEBEA
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 19:46:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxVh9-0008C4-Dd; Tue, 03 Mar 2026 14:46:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxVgu-00087C-7b
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 14:46:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxVgi-0000QX-TW
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 14:45:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772567144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s8HZgp9XakXoEVO+MoS+jYkmrGbeIxwxjBS2qScpvZo=;
 b=EChMztZlHsExNRxD1ioL59tqfWNZe2bLgpVsMvxf9MSdXc4+BQYlY/q97LuU0+meI+0L0j
 dtXp2jEQkuxsKnxGSO3XkFVVX/NQP3ZBdxg8megGlZVG3kVvBOflvoRU6l7q5oGyEnRH+N
 dUyHTyGDqDH8rAfxlueNz6Bn0CMdi2s=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-Gqm8STLUPwK3qQoDcjbePw-1; Tue, 03 Mar 2026 14:45:43 -0500
X-MC-Unique: Gqm8STLUPwK3qQoDcjbePw-1
X-Mimecast-MFC-AGG-ID: Gqm8STLUPwK3qQoDcjbePw_1772567143
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-506bfff75edso621366831cf.3
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 11:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772567143; x=1773171943; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=s8HZgp9XakXoEVO+MoS+jYkmrGbeIxwxjBS2qScpvZo=;
 b=djXJ00X6DkD9MKSYuzG8LKSBk8/Qr2L2jT9EUeiDWukd9i+EzzuL8GBToskGexnx5+
 khkuUoIhTqNMtRtLHBjKBPUx2JPGWFK+eYx3C1IwDNT1hGoiLd7Y2XJAoueeUyNG1KCE
 SymPRl0R4shGUHo9W4A3MvWNwGVR2jd/f/7k5JEDVWD4ErRR7Wa00N40HsY/NVRPbKHf
 tayyHRrJ634tOaHMU0J/4Tzb7QbTej0idsfDIN+83GPjN5Xiz8KT7JXqCJdhE8DC3lwz
 nUGB+S1wsxf96gFfdXbalAd9oumgDPW9VPydMhO/7yypeXpw73uI9NQ2ZC/w2mWGEUCM
 2irA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772567143; x=1773171943;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s8HZgp9XakXoEVO+MoS+jYkmrGbeIxwxjBS2qScpvZo=;
 b=mw0+A4r/f3Qz0h8+uf5m9RdwuNVpKe+8o5LxgDxh+swE5YqSRN9EAd4eB++q6aF14u
 qOLRCZ7px8RIv9bNNJtWaGbGDd/na1p5vylMYrrXafHX6BaUKOdVuH+JS1aM0hP4/E1e
 aL2z6x3CgNRZbZpZ0TKBu/CjxHVs4zWkIkR4q0IRE70b4TipXTG20NV0M+AWatJj9QA6
 iivW6XxTj3c6SI9RzdtpOeyBUvQ40bWvTbst4wKwvjYILZ+RT/P4POf/gakBpCT5zK74
 9F6HK+d9AgvPswMnZiflzW/viitUJb7Xkqbq9H98/vWAEu39RpBDxkcy09f7XmgOjlfO
 DkuA==
X-Gm-Message-State: AOJu0YzoewVarKEi88KL+zdZSOGRJehAmxgsaRzpCVG3GYKloX7JaJeS
 9T8Ozgnyq2vzcnSivlz+0u3z6C0Aa3i+hYXyN6MNDK1lMu3IAhYBP9mXp1gY5hOcNq7bLBgZkjM
 6l71x2315FU1u0Nxm+4qthCkRuWupAU2ILrUaBEFDRlqRhrbtG8zUgYc7
X-Gm-Gg: ATEYQzxchCBAlOrgfcz53onscKhjwlWiub5VHFhYAX1WjnwNwdFoHUBHs+tY97ZA0UB
 No9iO0Ve2FQnYp1VXu5kQClHVsqtkto3TSMJoN3ESFTpO0dPnTgRaTkhsWbdXW6yjEFIiK4EiIp
 1vyRdcXpknJceYjo6p/aWTeoe1lxMpvyh0M82bDHwzeeWwEKBoESsuMz2BVz89kSq2ZGj4sBjIE
 Q9DnMibzZUuIDnOL/326Gjye18N23oExhBt0olG6t34M1DOqkqOle2Y79eL3/tbw9DPmQ9S2bry
 lhncL4PREZEzmgbzFTaNjE+tskv6FtLPoNTX72ngXyEj6csxmBeI3P1GjV8nDn2Yzn6mk6Gj0jb
 BVScQUdnzQRbcew==
X-Received: by 2002:a05:622a:1654:b0:506:bdd1:798 with SMTP id
 d75a77b69052e-50752936717mr211228221cf.52.1772567142922; 
 Tue, 03 Mar 2026 11:45:42 -0800 (PST)
X-Received: by 2002:a05:622a:1654:b0:506:bdd1:798 with SMTP id
 d75a77b69052e-50752936717mr211227871cf.52.1772567142400; 
 Tue, 03 Mar 2026 11:45:42 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50744986357sm132369131cf.8.2026.03.03.11.45.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 11:45:41 -0800 (PST)
Date: Tue, 3 Mar 2026 14:45:30 -0500
From: Peter Xu <peterx@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Ben Chaney <bchaney@akamai.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Mark Kanda <mark.kanda@oracle.com>
Subject: Re: [PATCH v3 06/15] system/memory: split RamDiscardManager into
 source and manager
Message-ID: <aac6WsLDu3eygATm@x1.local>
References: <20260226140001.3622334-1-marcandre.lureau@redhat.com>
 <20260226140001.3622334-7-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260226140001.3622334-7-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Feb 26, 2026 at 02:59:51PM +0100, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Refactor the RamDiscardManager interface into two distinct components:
> - RamDiscardSource: An interface that state providers (virtio-mem,
>   RamBlockAttributes) implement to provide discard state information
>   (granularity, populated/discarded ranges, replay callbacks).
> - RamDiscardManager: A concrete QOM object that wraps a source, owns
>   the listener list, and handles listener registration/unregistration
>   and notifications.
> 
> This separation moves the listener management logic from individual
> source implementations into the central RamDiscardManager, reducing
> code duplication between virtio-mem and RamBlockAttributes.
> 
> The change prepares for future work where a RamDiscardManager could
> aggregate multiple sources.
> 
> Note, the original virtio-mem code had conditions before discard:
>   if (vmem->size) {
>       rdl->notify_discard(rdl, rdl->section);
>   }
> however, the new code calls discard unconditionally. This is considered
> safe, since the populate/discard of sections are already asymmetrical
> (unplug & unregister all listener section unconditionally).
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


