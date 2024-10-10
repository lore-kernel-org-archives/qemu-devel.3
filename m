Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F5ECF11F5
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 13:19:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syt3r-00087O-Q9; Thu, 10 Oct 2024 09:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1syt3k-0007zo-G3
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 09:18:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1syt3i-0008RE-Fi
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 09:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728566305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=BXUahZT8g9gR8x9+Vz0UnP16Y2DgXFxT1b5SUrtjUaZJ4SX6k+gmqa/jF2PBLZhV00ciy7
 1rihGTRPh4LI2IQtUK9q0sc/ZAf8hvJ4Nf19DexG2rwJQi8xz6rpErbd5zjxyXG2oMK6kB
 yXQtgIJ8jAKKPydA/l0yqEBFgp5GZ8I=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-sF-wq1ZPOfuyGQSV4DRHYw-1; Thu, 10 Oct 2024 09:18:22 -0400
X-MC-Unique: sF-wq1ZPOfuyGQSV4DRHYw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5c9127ea1c4so591647a12.3
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 06:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728566301; x=1729171101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=s2Id7wOBxd4+mCpbGYMliavT+uYJ8UZYfqI9yEAoLvFKaf6HH+usOtSX545WTRR0pX
 PRiSpPsvPqhz8OQieG7L7sC6zYPfmRjEtCZ58gQvpsNErO9i8qOT+uN3w2zAhfPVKxep
 H0z2zd9/5duZcF0cQ+Y8CXsp0AqFs6kuZYSHvBkdsRPVQr6vAuCbMoegV8qNsl0vVCMG
 UYhVEOoafotB9TeIhUE4S8edTHFPCMVyOjvBCAiiuhbIFR6afZ1Nvs+/84x/yzdN5H/P
 xz3d21jH8n42+bfoV1CrqqSSx98iqR5e9j7DTuEQ2Xyuap1rvmT+zsgNM87cdakqungK
 cUtw==
X-Gm-Message-State: AOJu0YzDDFv4i8238P98bm+uYkFYBsbJkFsGCIJo/U7J4GAPbSaLaurl
 cW+LXbWaLBQNRyiZooiH9BIqcNN1b8hOCMIi5TcDJymQRY3leadsyrDyiyVhswLu1GUl1KJ1sM6
 dOzQX9U3c1wLp6LCxfvMsqNd9NT8WAVxOaTfaj51jIbNIpGmtyg4x
X-Received: by 2002:a05:6402:210e:b0:5c8:8322:b154 with SMTP id
 4fb4d7f45d1cf-5c91d634834mr6239242a12.16.1728566300633; 
 Thu, 10 Oct 2024 06:18:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcKfCY2t/xEzHt4lbJrpOWa7fJw6nigUOXotbLilUDEINHJAoWCR8ImJWaacbEp0MlF/UQVA==
X-Received: by 2002:a05:6402:210e:b0:5c8:8322:b154 with SMTP id
 4fb4d7f45d1cf-5c91d634834mr6239207a12.16.1728566300225; 
 Thu, 10 Oct 2024 06:18:20 -0700 (PDT)
Received: from avogadro.local ([151.81.124.37])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c9372632a4sm768705a12.78.2024.10.10.06.18.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 06:18:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Chao Gao <chao.gao@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, jmattson@google.com,
 pawan.kumar.gupta@linux.intel.com, jon@nutanix.com
Subject: Re: [PATCH] target/i386: Add more features enumerated by CPUID.7.2.EDX
Date: Thu, 10 Oct 2024 15:18:14 +0200
Message-ID: <20241010131814.1804306-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240919051011.118309-1-chao.gao@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Queued, thanks.

Paolo


