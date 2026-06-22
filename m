Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20993CDB475
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 18:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbjjy-000632-Tu; Mon, 22 Jun 2026 14:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wbjjv-00062f-1S
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 14:51:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wbjjt-0007sz-NE
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 14:51:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782154280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QNmwzWAOHcin90/9slWfFU2tK5q8AEIcQ5XlwUerQn4=;
 b=Ckq2iU5X4wso9oTAp/yfqo8fuBfmS0I+/jCtF3YTu3dS+GNd+Q/xE9xoMXKiA63o+LINly
 ceIrrgmvMbSnrkQxWMj163MX/fyfnzuc79hyBljbdi9TnVz/djLxej8VF+nQJJD4R0QL0E
 5bkf2Lq7NvBhkv+MU6suhcpZlTSapKo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-DUdgROCxM5KVPl5xb9mnbA-1; Mon, 22 Jun 2026 14:51:19 -0400
X-MC-Unique: DUdgROCxM5KVPl5xb9mnbA-1
X-Mimecast-MFC-AGG-ID: DUdgROCxM5KVPl5xb9mnbA_1782154278
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8dbc0f048efso139047596d6.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 11:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782154278; x=1782759078; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QNmwzWAOHcin90/9slWfFU2tK5q8AEIcQ5XlwUerQn4=;
 b=ZnlAO9QIhkC5SWEERIuFJbmQqVRfx9xOuhpeElpY2CfOvv68hYo9uGiCEYYS+3GoEE
 ZNSvLqCB9sANvLVKXVSSVFariuExSVZkck6bf2zZgLOgSgdi+OFwmsnuyDpqhkVUjL1x
 yzdNzQCwBymaTSjO2cSWC2+6gGpo92Im3XRNpMvV03sHSjxrvSYDt7cLHiSHeDp2Do44
 CNB4NF/tLsOisFherhyoilOrfnGB4NT9Nk5oxQ4zqHU8UJol+peDL3W+y9RYpuP1UGIY
 +Vdf4UM9X5CSSscpv4BriRi02sZv+muyNIdYe4BL0Xry+nri2/csO6tgDlfdtaVXPDMO
 uUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782154278; x=1782759078;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QNmwzWAOHcin90/9slWfFU2tK5q8AEIcQ5XlwUerQn4=;
 b=aGMdkY1aoBNkevWuaFLa/rMhHoHkFeAnlOhoKqKpMKGyCGtxXcrtwogF1yQzgmo1DF
 of30HVBjUeNBBMyQCLCmdNPhsTVqZww+x5lB9sh1TzISbR6xIeGlIjpkmxubyOcPLF5j
 Jp78i4BNli821P/bE9HHt3dj/xKmDDvOuQIvsAt4N1pCblbC/Gz17+GPh/YZoLY36xJO
 9ivC034nQagZ6bXIyfWiRc4tuo8ksJYTJprhZNq67a+EX/09mBmzefaZjpOEKjM2+3KU
 yIWJuskcmkulzztqGN4QUT5CuofOrthqwpErFDBbBQDLbwqyJjqyZ5WunY72lW4peOyx
 0efA==
X-Gm-Message-State: AOJu0YzcqKfsDB8fOu7AmM1bhyi65LIgSpaokwbZNcnli4CwDBqsmo5x
 saStNBI8Fr2/+NfGd4P/7XDh2FKOls7XDPP8oQtxfw3DllcpHIpNQjiSXw6D3oXOXZVta9hirIg
 jVWN+2GUxYNS86pVYZdWajk25xVFWZTPEcrmx2FTqNqfVZdLs9YCaowOp
X-Gm-Gg: AfdE7cmeK4wSsEAJff7Lp0ncR2vvwadGIBvY62KKbidvtksGKf11nOPiWeWhA6WUInT
 ZhqrRoi/VnwRYW4V0TKlHEdICED+WhuTBiKAu/Q2BvpIxxJByhvc35Japsvrd44d1BR2gMIoTkz
 kq/iuetZVJ3JiG3dHgyjuAILtWDZWFAkMgeSK1UEudVRESvIlfKXCv3eAg8gYGyR+qXrJCVcC6b
 v1+82jgB0GSPMaidRVWMWd+u34zMdyhdyagQwffqhyg+7lln4/NW0LuB8htYnxREztOjimBbwy/
 IXXeRnVMkwRBpSOLAy0VRDNz9YFE6Q5QzAama63OwilHrhjn6zSl/S+40H/xeko4jcrkdO5f4iD
 skEKMBNdHa6YRrV7S/Wl2qwoFIRuDiIuYOj5+kPYfxg/+rpn6oPpqE+o3ykZEwgTUx1ZIws+3
X-Received: by 2002:a05:622a:13:b0:517:57f5:e21a with SMTP id
 d75a77b69052e-519e4c89d71mr247070031cf.41.1782154278226; 
 Mon, 22 Jun 2026 11:51:18 -0700 (PDT)
X-Received: by 2002:a05:622a:13:b0:517:57f5:e21a with SMTP id
 d75a77b69052e-519e4c89d71mr247069601cf.41.1782154277717; 
 Mon, 22 Jun 2026 11:51:17 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-157.dsl.bell.ca. [174.91.117.157])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51a51a9a3a4sm4755171cf.17.2026.06.22.11.51.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 11:51:17 -0700 (PDT)
Date: Mon, 22 Jun 2026 14:51:16 -0400
From: Peter Xu <peterx@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com,
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com
Subject: Re: [RFC PATCH 5/5] migration/tests: remove capability conflict test
 postcopy-ram+mapped-ram
Message-ID: <ajmEJHrSQdAjqTrc@x1.local>
References: <20260618032010.88755-1-aadeshveer07@gmail.com>
 <20260618032010.88755-6-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260618032010.88755-6-aadeshveer07@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jun 18, 2026 at 08:50:10AM +0530, Aadeshveer Singh wrote:
> Remove the test test_validate_caps_pair, which asserted postcopy-ram
> and mapped-ram capabilities cannot be active together. The new fast
> snapshot load feature is exactly this pair of capabilities active
> together, with the previous patches in this series, this combination
> is now supported and functional.
> 
> No replacement test for fast snapshot load is included in this RFC. A
> test exercising the full save/load flow will be added in a follow-up.
> 
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>

When sending formal patch, let's make this the 1st one otherwise previous
patches will start to break qtest.

-- 
Peter Xu


