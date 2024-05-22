Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D84DC25B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 09:13:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9i2C-0001FX-OM; Wed, 22 May 2024 05:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s9i2A-0001FA-Ms
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:13:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s9i29-00031a-E0
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716369196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=cgx5DYO8lakPLxAj9HZP9PCrD4JapxhF1SCMsmg+FP/dBZLXfWRcL0XjZCQwtIBMhFBvAb
 eb2brWbXDAmrXmJJFNc9hRvebbxBL7+5zh9WbE9TeadOSnNrCUqSJXVFwgl+j7WXpIZrdZ
 AGSaYNslEGHL5JHBBNwhw/eDMMggo40=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-MmRcSoT7Nhi2pA1mKvv-Cg-1; Wed, 22 May 2024 05:13:14 -0400
X-MC-Unique: MmRcSoT7Nhi2pA1mKvv-Cg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2e1e7954970so114341451fa.2
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 02:13:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716369193; x=1716973993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=HJYlCTDQL+5224D1lRehIEh9TbaQUu+lH/pMGJbXSUbxp3mpCzVmT0QKnrW+TqwaHV
 dys4KeDWOmcvLDpabcAucCjVhekt4r9QZxINnAyKhebp5pqE/Y6YDPyWKd9vKqsgXpTE
 tEAnlOZDIVFqsoMwoyXqTJkmkrn2S8l8TdbHGxzmQ+ZuPVvodEPX7b9ylz/B6zjMdqXb
 kdnllEpE80ftGxo7ktLuxwVxKOX6CNHOTuI0ZDsZ+WzEoEECA4M30hnZYkyQ/yLq6nDq
 oNQdHb3F80sEE6cwAkl0EC+lk/bQz8Iw+aA/xYJ+57egubqHVDjxzztpT75NARjkPeJi
 t7Ng==
X-Gm-Message-State: AOJu0YwityViAWVSsGsE0jDiMZvNHKxKSRI/NVE0t7tg238Fa4RGaTUU
 GFaZTzWXVilDnvJlzXFBDVH0HarjXSvgRHkRHdgh8Ay/RwdQ/BYJwMhjTnd7iXnb7QGwDFn84Kj
 aqgyUrIv9z8AXMDmxERXedrYZeeDm8D3I6NXEPh9I6bRVUEU5K4ue
X-Received: by 2002:a2e:240d:0:b0:2e6:935f:b6d3 with SMTP id
 38308e7fff4ca-2e949466edbmr10570191fa.14.1716369192780; 
 Wed, 22 May 2024 02:13:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFpyyA44hFQF4ppETk7HLGaQKmoD1bt87vKreKCyrhr8nGC5a7wmKaHL7suDwGgp7m4Arn4A==
X-Received: by 2002:a2e:240d:0:b0:2e6:935f:b6d3 with SMTP id
 38308e7fff4ca-2e949466edbmr10569971fa.14.1716369192348; 
 Wed, 22 May 2024 02:13:12 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a61a00e96c1sm392966266b.151.2024.05.22.02.13.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 02:13:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 xiaoyao.li@intel.com, chao.gao@intel.com, robert.hu@linux.intel.com
Subject: Re: [PATCH v4 0/2] Add support for LAM in QEMU
Date: Wed, 22 May 2024 11:13:06 +0200
Message-ID: <20240522091306.567300-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240112060042.19925-1-binbin.wu@linux.intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Queued, thanks.

Paolo


