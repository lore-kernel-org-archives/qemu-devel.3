Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A59D0C3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 12:55:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWbW0-0003Ka-2I; Wed, 24 Jul 2024 08:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sWbVx-0003Jr-Ak
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 08:54:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sWbVv-0002eu-Ay
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 08:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721825677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Oqr9eVehZ720oXrureEdo+Y6paUe8GqbUU+cH7Rojs=;
 b=MFtArxddWudQEVsCV+lKGqnmLniQc7MfKdtFA/IKPAOSs/FEcgIquS+7UNnB8JsJzlSE5T
 LDOLXe/SkgWoW9n7pzef94/ABH8gdJb2TU+D6TlAvLTvyoyjCmj9Hw1b7pS29xPLjbQioh
 Zu0ctakdxksI9RecBUh5q+v2QW2A9qE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-SCEIE4BvOgmhUNYyscUUKQ-1; Wed, 24 Jul 2024 08:54:36 -0400
X-MC-Unique: SCEIE4BvOgmhUNYyscUUKQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-36871eb0a8eso3800643f8f.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 05:54:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721825675; x=1722430475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Oqr9eVehZ720oXrureEdo+Y6paUe8GqbUU+cH7Rojs=;
 b=uoaWkxqXLGTexs4rHVtRJ5yXwl0J87gc+76N5bTIwCC3xE6Mi4Pu1SdyMDYt8frbZU
 fKuUw2ewC1EER1/o0DcJ6I34J7EkLpIi5gURaGZqVr4S8HJaaFxQp1SMgclxsnALYqR+
 REPOmkMcfZD1UINPXP0TNXuJPkZvB0eZrKroKoqOpVCnfvvyhiRup+zmeBxUPoRiGjGH
 OUpZQ9VtjEUNW+RRaY/7lJM98OI04gsu6yAoZxWEyrGODjj3USKZi1QttDVYJUuJgTqX
 EsdADsA5yfSBFHsX4ZCz+qz5J3PKyyNUCwGw9ZrxJk1uXpSFmYbf7Y+jXNobjYAQ1NmW
 7+CA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpV7eGF4axKntM0FLoPxDh4GTf8HKfmo6GP/2s4JEsK8QzgwU0fzj9HBCDijWzE5xMOvPtrT5H5pPatcZ/7wgFpVHd9f4=
X-Gm-Message-State: AOJu0YxRuR++LFhfYVlibsREbm7WOrqOCN6MYZTQ1swgxf5xeehMjP2F
 +WFtC/A4haj+FmaJcIZV/OI/ZFMDorSLfh6zwFYvxOW+jNy0/mXyT/4ZAUcos3+Q9yGhyaIIpL9
 m2nUAGkDXeC4q3uo8mxjZ1biYe9jvB3KXNX0jZEPz0wNjXbdWKyuQ
X-Received: by 2002:a5d:660f:0:b0:367:905c:823e with SMTP id
 ffacd0b85a97d-369f5b1964amr1361671f8f.24.1721825675107; 
 Wed, 24 Jul 2024 05:54:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrE/BhA+gGoOlbHV2cSo1+wZaTiOrKg1SDfAMLu8ro/KynvdIWffuDSPLgtKvrCJOfXU75ng==
X-Received: by 2002:a5d:660f:0:b0:367:905c:823e with SMTP id
 ffacd0b85a97d-369f5b1964amr1361654f8f.24.1721825674629; 
 Wed, 24 Jul 2024 05:54:34 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-369f7f4e1desm1598661f8f.75.2024.07.24.05.54.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 05:54:34 -0700 (PDT)
Date: Wed, 24 Jul 2024 14:54:32 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: John Levon <john.levon@nutanix.com>
Cc: Manish <manish.mishra@nutanix.com>, qemu-devel@nongnu.org,
 berrange@redhat.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 bob.ball@nutanix.com, prerna.saxena@nutanix.com
Subject: Re: [PATCH v1] target/i386: Always set leaf 0x1f
Message-ID: <20240724145432.6e91dd28@imammedo.users.ipa.redhat.com>
In-Reply-To: <ZqDh2NIE2ELRcwq6@lent>
References: <20240724075226.212882-1-manish.mishra@nutanix.com>
 <20240724110004.389c1a0c@imammedo.users.ipa.redhat.com>
 <21ca5c19-677b-4fac-84d4-72413577f260@nutanix.com>
 <ZqDh2NIE2ELRcwq6@lent>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 24 Jul 2024 12:13:28 +0100
John Levon <john.levon@nutanix.com> wrote:

> On Wed, Jul 24, 2024 at 03:59:29PM +0530, Manish wrote:
> 
> > > > Leaf 0x1f is superset of 0xb, so it makes sense to set 0x1f equivalent
> > > > to 0xb by default and workaround windows issue.>
> > > > This change adds a
> > > > new property 'cpuid-0x1f-enforce' to set leaf 0x1f equivalent to 0xb in
> > > > case extended CPU topology is not configured and behave as before otherwise.  
> > > repeating question
> > > why we need to use extra property instead of just adding 0x1f leaf for CPU models
> > > that supposed to have it?  
> > 
> > As i mentioned in earlier response. "Windows expects it only when we have
> > set max cpuid level greater than or equal to 0x1f. I mean if it is exposed
> > it should not be all zeros. SapphireRapids CPU definition raised cpuid level
> > to 0x20, so we starting seeing it with SapphireRapids."
> > 
> > Windows does not expect 0x1f to be present for any CPU model. But if it is
> > exposed to the guest, it expects non-zero values.  
> 
> I think Igor is suggesting:
> 
>  - leave x86_cpu_expand_features() alone completely
yep, drop that if possible

 
>  - change the 0x1f handling to always report topology i.e. never report all
>    zeroes

Do this but only for CPU models that have this leaf per spec,
to avoid live migration issues create a new version of CPU model,
so it would apply only for new version. This way older versions
and migration won't be affected. 

> 
> Yes, that would mean that if something requests 0x1f leaf even though the max
> leaf is lower, they'd get data back, but it's not clear why that'd be an issue?
> 
> regards
> john
> 


