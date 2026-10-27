Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F02B606A32A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DDz3s0CM;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=oUz+14Z2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLfgP-0008PV-5v; Tue, 27 Oct 2026 07:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xLfgK-0008NT-R2
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 07:49:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xLfgH-0006T8-C1
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 07:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793101767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HnQ2Wsayjf9bC4MV53l86zWe51L+ZTWcvERRxg4QuxA=;
 b=DDz3s0CMf7vWhUxd6IVXW/PDZr88GtssS0jCkdNFgo3MhNpQV6jYu7/CBWndGqXSjRsiPQ
 4K2L3nOwQIXiE0Hkr62wFajpd1uVNqPgeCCVL7j4p7kuAwddjNuf10+jrNTCvNp8672Lr0
 VivPjf38bpJFfRIBmm4gyeeis0i0jIA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-pjGIEUlwPSuATfzo9UWbHA-1; Tue, 27 Oct 2026 07:49:26 -0400
X-MC-Unique: pjGIEUlwPSuATfzo9UWbHA-1
X-Mimecast-MFC-AGG-ID: pjGIEUlwPSuATfzo9UWbHA_1793101765
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a4af69e06fso18296265e9.2
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 04:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793101765; x=1793706565; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HnQ2Wsayjf9bC4MV53l86zWe51L+ZTWcvERRxg4QuxA=;
 b=oUz+14Z2aYHXGR0QiOgloRNTVCzddq0kLZZu+NR+TZg1oYJtxosWO6DGhm4JRuZhEI
 xPa3Jo+O+JyKSk4IpSix7zfNPdGvxUqYr/sJxcVyE42JhpvY5Sg6p7obZbP8pgOJ07jv
 1qMP2ITmlfykzONt4iVuzeGQRQ48TLd3xyyX8Srwgpc1G8Sca0ahBLM54lae8b5I8nNc
 idDRusQJCae3yNCm0vAYmccu4jlkCaZGByFv8isFsftZbt8sdft1JhSDMldicdl5KCys
 HK+8+cr92fIUeDRrgT4c4QQZZfdMDYg4h5eVfPBR3+cSW9kFGTM/sKE53fiQAgtd9pVn
 hadw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793101765; x=1793706565;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HnQ2Wsayjf9bC4MV53l86zWe51L+ZTWcvERRxg4QuxA=;
 b=wLOjQN4SPEOlXSDwBOBwkDiz3eBZMDYFmJEP9kLjXPxOOq5r/xEjgCbnzh3OR07WSU
 ZXG1zKpc0AXYZ1EqrhvPKMBk//kbmZKuI0A3pywFvktOoJBm7LV2zIQNJ6G1UzXW2gxC
 CV41dyd5ixxq7dJmaHw+XPnq5nvaWxKfQzYWItGJXboKplNhLViWV5ZSrYl4WW1xTUVW
 VHPR9zLqYy/OEKLPyLUFHv9UGbm7MeqwjVDY1UvFR9yWxyb3U2RN87B4WSIcjQ3ZMLsc
 G+fmoPpKhLX/iFXqeC2cXmGJn6FDl6pBkycdGP3Sloc5OcvBqVDnAfCLe0foIgufqCnP
 AqBA==
X-Gm-Message-State: AFq9FYIaztm1n8NJhj5oPL/3Jw6rwdOcqd3JoHfiZutPI6mRiCAVwdVR
 /PEOx2+QOocDVNr07c3XAN+/6zSGSzpzZYSNsqEqOwPAN+97565WbzHxZRO8m6QLm9t5u0+F8i8
 0QtPiEY2g6tt1lfs/waONxs50VL+Xn0K1H9m/mFylViT1wbHWRUsC/Lpv
X-Gm-Gg: AYBFou1q0RLMAfLQplF4lXltsFwJLZqwzfMpKSDvXkjzmPxO5oLtxXX4fOauLRKnqqo
 mTPBXrlOiWxIpp5SDUi6GHqqc6ugQQTCc6NmxNoDYE1E+xZXxEyXsG10Tl/QCyYfW3E+pCCnCl6
 CoGIArCt+E+0wXSHGP+nduwL2aaND8oOt/ftHXMNyui3bOiIHhNpCN2bZZ4NX+xMl+LYn8yfkSk
 lmOUXxp2GraWlXbm6vE19L6f2ydwDfZ9HD6vXjCkpZxlwzajUdc7BFIs8lA9vqUC0AYIKkhid+w
 WwmpPDpm4Ffn3cfxEUQJxl0ftfHSp6dxO5cRyneRPMT6lGX4+GBd0TqlMqYwzFUbLbY=
X-Received: by 2002:a05:600c:4f0f:b0:4a1:acaa:c355 with SMTP id
 5b1f17b1804b1-4a35ac803e2mr218505435e9.10.1793101764874; 
 Tue, 27 Oct 2026 04:49:24 -0700 (PDT)
X-Received: by 2002:a05:600c:4f0f:b0:4a1:acaa:c355 with SMTP id
 5b1f17b1804b1-4a35ac803e2mr218504835e9.10.1793101764403; 
 Tue, 27 Oct 2026 04:49:24 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359f59750sm175965235e9.0.2026.10.27.04.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 04:49:22 -0700 (PDT)
Date: Tue, 27 Oct 2026 07:49:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Vrabel <david.vrabel@nutanix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH v3 0/4] hw/pci-bridge: Configurable apparent bandwidth
 for the PCIe topology
Message-ID: <20261027074859-mutt-send-email-mst@kernel.org>
References: <20260928152431.310363-1-david.vrabel@nutanix.com>
 <6fa1a07f-afbb-4c65-85e0-ddcebd9bddec@nutanix.com>
 <20261015101016-mutt-send-email-mst@kernel.org>
 <712fbce9-8b13-47c1-b0cb-b9f20807f05f@nutanix.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <712fbce9-8b13-47c1-b0cb-b9f20807f05f@nutanix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Oct 27, 2026 at 11:18:27AM +0000, David Vrabel wrote:
> Hi Michael,
> 
> On 15/10/2026 15:10, Michael S. Tsirkin wrote:
> > 
> > On Thu, Oct 15, 2026 at 02:41:55PM +0100, David Vrabel wrote:
> > > 
> > > ping?
> > > On 28/09/2026 16:24, David Vrabel wrote:
> > > > When a VM has been assigned a number of PCIe devices behind a common
> > > > PCIe switch and the VM intends to use peer-to-peer (P2P) transfers
> > > > between the devices, it is useful to be able to more report the
> > > > apparent PCIe bandwidth so it reflects the real handwidth of the
> > > > underlying hardware. This allows software in the VM (such as NCCL[1])
> > > > to make better decisions about whether to use P2P or not.
> > 
> > will merge, thanks!
> 
> I appreciate you might be swamped by a pile of AI-generated security work,
> or perhaps I'm missing some QEMU-specific process (merge window?), but can
> you estimate when this might be merged, thanks?
> 
> If it helps I can prepare a gitlab pull request.
> 
> David

This week, sorry about the delay.

-- 
MST


