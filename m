Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702B1C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 12:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYPL8-0001ie-Hu; Mon, 29 Jul 2024 08:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sYPL6-0001hd-Le
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 08:18:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sYPL4-0007lx-7N
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 08:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722255532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iHV4MXS48ouDo3fuFfPdRmfQIaIfwPHQIPJ2Azn6cPI=;
 b=UHIGdwN7TuflKTGfpKGyaW8c0XVEbVSKC1UOwLuaE1QreY20m8mQSXKj67d5GJ1toyyP2M
 Ms3Au4I3SGNuux50aS6YzQkJnCzpPQ8tKJZNOlOGCw7C3FU00jvDYvjYIW+GfjYXzxKxCn
 nzD0iv3wkQ6dMY3PCEMb5I9Os0Shm+A=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-0czvdAzEN7-QaH8M8kTG8Q-1; Mon, 29 Jul 2024 08:18:44 -0400
X-MC-Unique: 0czvdAzEN7-QaH8M8kTG8Q-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2ef2a44c3dfso29939701fa.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 05:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722255523; x=1722860323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iHV4MXS48ouDo3fuFfPdRmfQIaIfwPHQIPJ2Azn6cPI=;
 b=FPO9uncNf2ArgpltIb6pRZl7yILV4br+jHgdUFM5fNBR/g4qCv7fFa80Av+6y+rvHt
 axKr95qHwEi9uInFRv9sr+yE3w+4zZ6yBrzpKzrjLbojqnXWx0oGtRztvpKBQXVUUmUF
 vyOw+TwO4qvpPRgeElIZmZI5EK1CSxr1Xgynz8VNxe71xk0UOE/CANhXrZ0ouajHCxb/
 TZUKy78mPBRZ1B/nIyBmgYDYCPIN5QR1R2WKX9U/pojKVQ0kfz7zkCfq0kiLmNuLvwRN
 zLqvV1mf47Gy44QH7WrMJ8zndidjgsBOukgW1MfgQzuNSSxC3lfOMFmNnQuZAVXfmp9a
 6Wtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaC7ggNDdogwjDBH8i76EWkdbuV7mjEo6CSvqxtLTPslo3sbtMCYlBEcA5cNxoxVOF/Qhd5Qx+PxSgqYirdXMSeDPJ+v0=
X-Gm-Message-State: AOJu0YwTgPbd/NHcgEDcjoSBhRBfdT23y4rjR15vD/F4W08FED3GpRXJ
 IWGpllJ+wSywu17Yq0pFEWx4iAS/UbmIfk5rJDPt4nANbVIeJoDmWfcxfQlt5AceaVIrPb+gVu4
 n3ZQnNFKoVpyKdbDqAfbCxM2aOx8uW6ZuqKkHhL265lwfcjakh6LM
X-Received: by 2002:a2e:9c88:0:b0:2ef:18b7:440b with SMTP id
 38308e7fff4ca-2f12ee05d8amr48508901fa.12.1722255523497; 
 Mon, 29 Jul 2024 05:18:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtzA6eTfGdK11i95Jat1CnluAl6Spmn3Rhx090/WvKy3CNLui9mFuwRpG1sU2L7b28cONBrg==
X-Received: by 2002:a2e:9c88:0:b0:2ef:18b7:440b with SMTP id
 38308e7fff4ca-2f12ee05d8amr48508651fa.12.1722255523028; 
 Mon, 29 Jul 2024 05:18:43 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4280e7c64a6sm118929595e9.41.2024.07.29.05.18.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 05:18:42 -0700 (PDT)
Date: Mon, 29 Jul 2024 14:18:39 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: John Levon <john.levon@nutanix.com>, Manish <manish.mishra@nutanix.com>,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 bob.ball@nutanix.com, prerna.saxena@nutanix.com
Subject: Re: [PATCH v1] target/i386: Always set leaf 0x1f
Message-ID: <20240729141839.44203b6c@imammedo.users.ipa.redhat.com>
In-Reply-To: <ZqEW/TIZAqLN3CKI@intel.com>
References: <20240724075226.212882-1-manish.mishra@nutanix.com>
 <20240724110004.389c1a0c@imammedo.users.ipa.redhat.com>
 <21ca5c19-677b-4fac-84d4-72413577f260@nutanix.com>
 <ZqDh2NIE2ELRcwq6@lent>
 <20240724145432.6e91dd28@imammedo.users.ipa.redhat.com>
 <ZqEW/TIZAqLN3CKI@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Wed, 24 Jul 2024 23:00:13 +0800
Zhao Liu <zhao1.liu@intel.com> wrote:

> Hi Igor,
> 
> On Wed, Jul 24, 2024 at 02:54:32PM +0200, Igor Mammedov wrote:
> > Date: Wed, 24 Jul 2024 14:54:32 +0200
> > From: Igor Mammedov <imammedo@redhat.com>
> > Subject: Re: [PATCH v1] target/i386: Always set leaf 0x1f
> > X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
> > 
> > On Wed, 24 Jul 2024 12:13:28 +0100
> > John Levon <john.levon@nutanix.com> wrote:
> >   
> > > On Wed, Jul 24, 2024 at 03:59:29PM +0530, Manish wrote:
> > >   
> > > > > > Leaf 0x1f is superset of 0xb, so it makes sense to set 0x1f equivalent
> > > > > > to 0xb by default and workaround windows issue.>
> > > > > > This change adds a
> > > > > > new property 'cpuid-0x1f-enforce' to set leaf 0x1f equivalent to 0xb in
> > > > > > case extended CPU topology is not configured and behave as before otherwise.    
> > > > > repeating question
> > > > > why we need to use extra property instead of just adding 0x1f leaf for CPU models
> > > > > that supposed to have it?    
> > > > 
> > > > As i mentioned in earlier response. "Windows expects it only when we have
> > > > set max cpuid level greater than or equal to 0x1f. I mean if it is exposed
> > > > it should not be all zeros. SapphireRapids CPU definition raised cpuid level
> > > > to 0x20, so we starting seeing it with SapphireRapids."
> > > > 
> > > > Windows does not expect 0x1f to be present for any CPU model. But if it is
> > > > exposed to the guest, it expects non-zero values.    
> > > 
> > > I think Igor is suggesting:
> > > 
> > >  - leave x86_cpu_expand_features() alone completely  
> > yep, drop that if possible
> > 
> >    
> > >  - change the 0x1f handling to always report topology i.e. never report all
> > >    zeroes  
> > 
> > Do this but only for CPU models that have this leaf per spec,
> > to avoid live migration issues create a new version of CPU model,
> > so it would apply only for new version. This way older versions
> > and migration won't be affected.   
> 
> So that in the future every new Intel CPU model will need to always
> enable 0x1f. Sounds like an endless game. So my question is: at what
> point is it ok to consider defaulting to always enable 0x1f and just
> disable it for the old CPU model?

I have suggested to enable 0x1f leaf excluding:
   * existing cpu models (versions)
   * cpu models that do not have this leaf in real world should
     not have it in QEMU either.

If cpu model already exists, you'd need a new version of cpu model to
enable new leaf by default.

For completely new cpu model, it could be enabled from the start.
i.e. workflow for enabling that should be the same as with CPU features
(or as you said 'endless game' of copying base model and making it look like
should be according to spec,
but that's the process we currently use for describing CPU models).
 
> Thanks,
> Zhao
> 


