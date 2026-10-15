Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D694CC6B3A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 14:11:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHMAR-0008IQ-Tv; Thu, 15 Oct 2026 10:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xHMAG-0008HL-1D
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 10:10:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xHMAD-0002rN-FV
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 10:10:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792073430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=egczxxrFtvcYyfarEmFiFgyKZF8VWbLqP202pxHrC9c=;
 b=XbfHT3tjWvrG6QzCSGynxkuhvELeq87tgLQvSWRV5vRP7gzvVJ+93OPIuJVqOpnrCqzzzG
 C2dPiLM7rjnQVMJV4V1XDo2Gs/5WwutBrITOGGfUkNlKyHimEQbchApmD0i3UYUYG+NU9s
 D1ydXfI6sIP7zdzCFHDhnAq+S594iV8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-2Ax2coxdOxi8fvydCe3X8w-1; Thu, 15 Oct 2026 14:10:27 +0000
X-MC-Unique: 2Ax2coxdOxi8fvydCe3X8w-1
X-Mimecast-MFC-AGG-ID: 2Ax2coxdOxi8fvydCe3X8w_1792073427
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48b028d93c5so3912003f8f.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 07:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792073426; x=1792678226; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=egczxxrFtvcYyfarEmFiFgyKZF8VWbLqP202pxHrC9c=;
 b=af2vWHjrdEs6XnxrU1M2OF6f8tOmznxC5/94GTT1f3ZMrhYtt7FPgkY7oZP6nrh8Mf
 mKrm0Afxr2NPCfQ0NEFoL2v8n3BiWohEDLo0+/3X1/FDJBuaUX9LWr5MSXMcV7HzmeGI
 /i/rbCiYcuH+YeZsS6jDrXG50uAxG4Nvf+vf+XZ+9XZbv+rA5HCi/5PxzZE5YSqGomaa
 CsK5qXfZKiwyT7u09NTae2nK090kRF4qZRv8u6xg9VzYx46Wf9YVb9q+dwh5rAUXst4N
 uMmiXZ120Xpyp+3s0EYb176I+o1zv4zxp+iK+9pqBy0zOR8wtNd56WNSmYpYD+lwfDB7
 BMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792073426; x=1792678226;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=egczxxrFtvcYyfarEmFiFgyKZF8VWbLqP202pxHrC9c=;
 b=jc+kz3/6QUDmeXKc2hr801MF6mG4FDeZKSs8/yOCdHTdrfV2jkLdwhfWnFB8C4doc/
 De+cI8TrALk68R5Qu8BMId2yVKsxiIAl22uz3ZafQDdtySbTC2jlWoEN3A+TThZYybTK
 vwZ0Y0HeHDrWzYPr0zr/1XZWDMtnOz9sQvOcMiUO1Na/24K8Ozmg0hvLSa+Ki/nGXS6E
 V906+P5pMUSzZVGj/+e/lyDlEDJNp3L/2BMYbqDEnf1IniOy0XTksdAk+gSYEOehfJdW
 amHuXwH+MXQ7318f3o1uT3IRcT78mEm9nrg3UX8UdWgqn7O3lAZ7RwinElFm1/4DASYz
 l6iw==
X-Gm-Message-State: AFq9FYImEJERCx27PRSaKZDg6D8ubS21WiFWV1XSyJ0HDn1fcgwtaPK3
 vdLZCm+4Ha9knxMbkKl52b0Ib84A1PNLIuk9OKVKsKVcsByPJ7FhlzU4KmpiC5KhLUKu2MfZ//i
 QPnZMpDDngXv0CqCCs0d7I4OqI1mDCj+fTPmBBRjbPI///iiPMC4hsyvA
X-Gm-Gg: AYBFou1lbVgO1DERJF+m91vMU2dm9HMj28gXOP/x+8JG7F5BYK/uNQS9Ig7PaMLkaP1
 /0StbXFB7DEbNXK4HZZSe4mKeltl4Q8xWJqSIRDftIdwxBpbuzTiq1/PNSK8Rx72eubyr3wu2cB
 bDtA1BQ1dfTc4V3t87XC4FQ3XKHXcJLdwtJirXnGVBZ4TxCLCWnY9tRXfNZkSCFIMzRte2rkjYb
 zso5MHewtWNB3SZ9Gt3qkVpgW+4sj/FPGPyXHP13FBmGTHfB+RsA4jbbORv1wi9z2e18hr/dMIM
 eRhaHWe/vNdLhen0Y5LfA3le9vFgLxRn50yy/QaGzgdw7pxYgY6P0RudM9JZFLx0ibJTcg==
X-Received: by 2002:a05:6000:601:b0:48d:e61d:68da with SMTP id
 ffacd0b85a97d-48de61d6949mr16622964f8f.20.1792073426412; 
 Thu, 15 Oct 2026 07:10:26 -0700 (PDT)
X-Received: by 2002:a05:6000:601:b0:48d:e61d:68da with SMTP id
 ffacd0b85a97d-48de61d6949mr16622855f8f.20.1792073425671; 
 Thu, 15 Oct 2026 07:10:25 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bc5e0asm19148125f8f.50.2026.10.15.07.10.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 07:10:24 -0700 (PDT)
Date: Thu, 15 Oct 2026 10:10:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Vrabel <david.vrabel@nutanix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH v3 0/4] hw/pci-bridge: Configurable apparent bandwidth
 for the PCIe topology
Message-ID: <20261015101016-mutt-send-email-mst@kernel.org>
References: <20260928152431.310363-1-david.vrabel@nutanix.com>
 <6fa1a07f-afbb-4c65-85e0-ddcebd9bddec@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fa1a07f-afbb-4c65-85e0-ddcebd9bddec@nutanix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 15, 2026 at 02:41:55PM +0100, David Vrabel wrote:
> 
> ping?
> On 28/09/2026 16:24, David Vrabel wrote:
> > When a VM has been assigned a number of PCIe devices behind a common
> > PCIe switch and the VM intends to use peer-to-peer (P2P) transfers
> > between the devices, it is useful to be able to more report the
> > apparent PCIe bandwidth so it reflects the real handwidth of the
> > underlying hardware. This allows software in the VM (such as NCCL[1])
> > to make better decisions about whether to use P2P or not.
> > 
> > The existing emulated PCIe switch is a vintage TI XIO3130 and only
> > support 2.5 GT/s and x1, so we introduces new generic upstream and
> > downstream port devices (pcie-upstream-port and pcie-downstream-port),
> > inspired by the existing generic pcie-root-port device.
> > 
> > The existing experimental "x-speed" and "x-width" options are made
> > non-experimental, allowing the pcie-root-port and pcie-downstream-port
> > capabilities to be configured to match the hardware.
> > 
> > The pcie-root-port device is updated to default to a Gen6 capable
> > device.
> > 
> > Finally, where a root or upstream port's bandwidth has been limited,
> > we also ensure the other end of the link reports the same link status.


will merge, thanks!


