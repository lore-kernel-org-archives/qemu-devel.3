Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47CCE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 13:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVspM-0005vn-Bt; Thu, 09 Jan 2025 08:44:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tVspJ-0005uz-Dp
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 08:43:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tVspI-0003c5-5c
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 08:43:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736430234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0786u4iJInsHVvSrcuJUnfn4useWu9D1HBXhDMMX5P0=;
 b=iDumQGzqxoaITFrdc3xb99Xl70YxEPabU3WCj6fV65bG1nS/WJhMIIdHmq8GJu/XQ/2JY5
 Sjo5CzBXf6dnQzPWt/WzCa7qY5c4MCv3KdQi6vs99bl1z8wFBSbX05iU84Jp65n4RoN8ka
 2y/n1+VOgpcFZTlzPzJf7qm0WzWQm64=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-cXU8MjH3No2wYhZDkXMgkw-1; Thu, 09 Jan 2025 08:43:51 -0500
X-MC-Unique: cXU8MjH3No2wYhZDkXMgkw-1
X-Mimecast-MFC-AGG-ID: cXU8MjH3No2wYhZDkXMgkw
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43628594d34so5112465e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 05:43:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736430230; x=1737035030;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0786u4iJInsHVvSrcuJUnfn4useWu9D1HBXhDMMX5P0=;
 b=KirB/fnXs/m6TDuDO3wV5RmLZIWSuUu5WpXQXfBkxtHvicBUqhazKTZbFaTc1WsOcK
 Itu9zH2Y4hO2oKVsx470ywjQZ5ybFKh/eTxhpZZGrtj5BL5BGSIfWWQ2LNE6U35C0hjV
 7xQZOAHJosSV7DxCaFgmAUGRNzSNOEFkCHv2mj14s9uRaddzQUxruI5h7JoXi6iLqrd0
 7blJlfgVwmrDTEkKzFgNJIxIS41lNXSW3Z2lbNDPtC46GDtshAIHrqWyrZiR3J/1n1Di
 nCJSdmGdH8QzSTn9CzVjBk6WqOl8GnlBPo1tVLLkDruCQgRwQiuzcUtAN6sfMd2l4pED
 O/rA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3E8C8aej7ga63HX1HSoA4fJxWep1yG55C6FjDrxsMaNpcX1mrsGyloF97y5pkEeDWL87UFMaoKRUA@nongnu.org
X-Gm-Message-State: AOJu0YyYkISB6uOXUxLEGXw5dNkWHIJU8/jPPgVhppUd8aDFIFyJ5XXe
 OdA7m78fNC+Kh66i3ds1z/NHPM6mFz71cBon9/eUIm/DUg83TiXimxhsGETeUwYG90f1nqlx4DE
 XbVmvztFw6V7rZ/NN3iH2U6QjBeWjxW0mpKpgYpgI326qxr0u67lS
X-Gm-Gg: ASbGncsBSrEB+i+hKEbKux2qpPN9STEslsxRIGEjIhV4H3MFUvfCVtxUdTPKZpPDJ1D
 5WmIrV7Jf324jEQhtTH53705kX6GVyzZkt3fZNAtXtIvsBgzi6XlR0lweVmckUppFy1HkBvZcWi
 lUN4gufJwIyUjUFcMOvNb8kgvLb2kua9ErdiV8a0LWs5DoPk2+Dbp8EhnAgxv8nceElSqmSu65f
 9PZWxnX/zSpIz/aVSnuRLjAbRBK3IUpXuHEGZou7V7o9fUMc/c=
X-Received: by 2002:a5d:64af:0:b0:38a:8e2e:9fcc with SMTP id
 ffacd0b85a97d-38a8e2ea11cmr2516686f8f.45.1736430230131; 
 Thu, 09 Jan 2025 05:43:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFC3NwaqaPqm+7CAChl2hzC/Oe3iq4QPBPHiLKmCQp5T/gWPuAk1uYfxoykEr8rAwEDQAbBFg==
X-Received: by 2002:a5d:64af:0:b0:38a:8e2e:9fcc with SMTP id
 ffacd0b85a97d-38a8e2ea11cmr2516657f8f.45.1736430229806; 
 Thu, 09 Jan 2025 05:43:49 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:d62d:93ef:d7e2:e7da:ed72])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e92dc4sm55306375e9.39.2025.01.09.05.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 05:43:48 -0800 (PST)
Date: Thu, 9 Jan 2025 08:43:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, devel@daynix.com
Subject: Re: [PATCH v19 00/14] hw/pci: SR-IOV related fixes and improvements
Message-ID: <20250109084258-mutt-send-email-mst@kernel.org>
References: <20250109-reuse-v19-0-f541e82ca5f7@daynix.com>
 <86efce30-2727-4581-963c-3424dddf46e2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86efce30-2727-4581-963c-3424dddf46e2@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.436,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Jan 09, 2025 at 01:04:11PM +0100, Philippe Mathieu-Daudé wrote:
> On 9/1/25 07:29, Akihiko Odaki wrote:
> 
> > Akihiko Odaki (14):
> >        hw/pci: Rename has_power to enabled
> 
> >        hw/pci: Use -1 as the default value for rombar
> >        hw/qdev: Remove opts member
> 
> I'm queuing patches 1,13-14 which are generic, hoping
> it helps you not carrying a bit less over respins.

I mean if Akihiko wants me to do that, just post them separately.

-- 
MST


