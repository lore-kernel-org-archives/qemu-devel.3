Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD81C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 11:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi9Tn-00021Y-Eo; Fri, 10 Jul 2026 07:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wi9Tj-00021G-Vy
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 07:33:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wi9Th-0006zC-V2
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 07:33:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783683188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YPOTLikMUbxmBylzs9yj0VpuFFrAylpCohEJMhESojY=;
 b=Hclcwur/FnO/J1SNqjpUJxNoOk5lz6U4U4AJ/hNDhmSdZzB8eSe3J/GMZP86/S9YC6OMPI
 nqwdHhP8xpUiZNQnjMTpSoM5CcCtht+oTAoohWbnnK4j8SaGESMCsM7GDaOTCTCdsfvcZ6
 r87yej2zmpXGaw43GNbpuEJ23nZ7A+I=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-e1uAEZFMMLS_ryaCluGk-g-1; Fri, 10 Jul 2026 07:33:06 -0400
X-MC-Unique: e1uAEZFMMLS_ryaCluGk-g-1
X-Mimecast-MFC-AGG-ID: e1uAEZFMMLS_ryaCluGk-g_1783683186
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1d137a68so18781671cf.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 04:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783683186; x=1784287986; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YPOTLikMUbxmBylzs9yj0VpuFFrAylpCohEJMhESojY=;
 b=Ne3df6TqgizcQWtV+vMEIzwtrFb8FjhzB8U3cH+LxmM/a+nTG0VyHakdoyLoUkHTTt
 cUoN7ag5t9BQXfFUp4o+U2outY9W9QXxKvJi9daTtbizMlYGy3+qY1y2D276exk6/9ZR
 5Pj2b6l8epyjgE0s7ZctINxC2L/8dtnqhnELVVqETCJ7RhHD4vuKubJmzX6j8bVcPLp/
 c2SKP0awUUz7vOOT6DFviVpvoj7zVg5E2ZnEfDt/I1U9foerLzECuzlr3ohiDjiANigq
 SqsGBuShIM57JMeDuEuclmaMCLAXyTKt+cRieT6US959PfX6mtM+1kdJoSq8grFchbv6
 QekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783683186; x=1784287986;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YPOTLikMUbxmBylzs9yj0VpuFFrAylpCohEJMhESojY=;
 b=hzWs/Gm61rDnde+VdyzMszjnrNXci5m47cppvITfRfhR8ycoqvG5t3gc571Sm4JEEx
 XJ44VwDwkCxQfcKzzTrTLFFcQq55xQ0HKR3qniD1mFwdPAjVM3QA2SUJ9OIzQNID6Z9y
 9L5IQ2P+dr6o0+GKNB/RgZvDzE8GyD7P3ji6GQHRJM0i1xFWYDhFz3FHT+qUG07nQuyG
 yLPbpqwVH6NCkF7jXyNjzIC7OtQaxKjDxBb9l1LM/0A60Vy4MptiOtSfvphlNFyXSPiu
 Fqh2dxy4eDvTm7ylPer1PfDeiJE8Xde+6UYR46BhCw1ekZr6OwVle72ToJS3eqWhVmnp
 ulBA==
X-Gm-Message-State: AOJu0YxnGsanw2+WiKWMXDunYkTv2vwmOM+8d6eI1R92vuezdVqqrrt9
 dK0FaSSgCglT6GRQXbga1Crsgn/fU21pyG+0DBwX8YMd3DnTBXbQ4TQBqkpsbSbU0nlUtWrLZe8
 WVzDAMAHjoBj0vga0fSoFI2r/dmDHEzlWYMSVNvyoowGwCTHKElGfBQM2
X-Gm-Gg: AfdE7ckPZLXGN+YoYakqJ9CnvzjQMqhPfF9uY8yjuyVT/n8zS/IDWDK9g0qV92H0doO
 K/9BeOfWXGljfghBx7zVP3UQJZ05pkv1ohSlmdBaoyEsL0Z//HJDaRNRMj1bqDVXq9RD2uSvg5L
 ZjR9jTL/hQJyyDlHOpA+yhR1kkcaxFx8PiRdYPDla+vtC3ueJJwV+uEnKTY29wvNGQWzfW2Wr+3
 OR2svFcJcJQxiRyiRF2/JMUZZjLz0d9RLcQPik3FLjavBCFRAo9KDXcbsvedRUGTTH9APWzJlPr
 PUQRkfGEplEfsa+VkmeNdkb4di5QjEiuxCHnm01tHDea5DnTdH8yIgYC0Yxh6Khhq7fm33IxTwf
 HNQxXb/pCcJkTiloyhIJfLs3C7OGBIU5DvNz4gMxNAggn9Tg=
X-Received: by 2002:ac8:5fc1:0:b0:51c:18e4:38ab with SMTP id
 d75a77b69052e-51c8b4c77b9mr113984081cf.66.1783683186002; 
 Fri, 10 Jul 2026 04:33:06 -0700 (PDT)
X-Received: by 2002:ac8:5fc1:0:b0:51c:18e4:38ab with SMTP id
 d75a77b69052e-51c8b4c77b9mr113983851cf.66.1783683185594; 
 Fri, 10 Jul 2026 04:33:05 -0700 (PDT)
Received: from leonardi-redhat ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51caacbf3b4sm13444061cf.10.2026.07.10.04.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 04:33:05 -0700 (PDT)
Date: Fri, 10 Jul 2026 13:33:01 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, mcascell@redhat.com, peter.maydell@linaro.org
Subject: Re: [PATCH v3 4/5] hw/uefi: account variable policy entries against
 storage size
Message-ID: <alDXeMFlFCr3q6Ar@leonardi-redhat>
References: <20260709104223.143594-1-kraxel@redhat.com>
 <20260709104223.143594-5-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260709104223.143594-5-kraxel@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
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

Hi Gerd,

On Thu, Jul 09, 2026 at 12:42:19PM +0200, Gerd Hoffmann wrote:
>uefi-vars already tracks (and limits) the memory footprint of UEFI
>variables.  Do that for variable policies too.
>
>Fixes: CVE-2026-61405
>Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3890
>Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>---
>

Should we decrement this counter when policies are cleared?

Luigi


