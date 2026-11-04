Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D680F606A330
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 18:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=packetfive-com.20260707.gappssmtp.com header.i=@packetfive-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Kqn3sdk9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOfSo-0000Mn-RQ; Wed, 04 Nov 2026 13:11:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1xOfSk-0000LO-H6
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 13:11:54 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1xOfSi-0001ly-5b
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 13:11:54 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-490c1d337d8so324562f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 10:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=packetfive-com.20260707.gappssmtp.com; s=20260707; t=1793815910; x=1794420710;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IwAVqtbOnegWf57bOaozHarqz+jJInOzsXpgIqX3Xx0=;
 b=Kqn3sdk9Z7y/9FukAFFc1adiUY/DlDdwGwV7oONX8+CaFj6h2FkMa4uO5GYaM87rKA
 G6w4UIoXYwMzgmhAMulma5FNfN+CHDBdY1qgkzLnSKdgTrr8YY7WKs9qkNR8PD3YB0Cp
 y0lL52LpBNzX0D7BWj6VmesJNZ/SFFWOpAdi4Amcf3O/DgE7L367fFHC1nyUxDbcPa8m
 OYv6lxSb7I3aTgOs5DORfyEy4BA4d7Vr8L/Qywhug2nwuWIEV4P8JkCQFI+HBWW5s1wg
 vNMlLmaZhvV+HJZEOc5CUEqFQrDAZcduBJ+t+1mSuIDLe67Y7ek2W2qCPQ1xcI+S01DT
 AVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793815910; x=1794420710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IwAVqtbOnegWf57bOaozHarqz+jJInOzsXpgIqX3Xx0=;
 b=rsihcRelbhn6cWGXRynSw9cqNGhHi+ds4+59qpmCouagnFYHaXVax54BNMtDT/ChnN
 Io5/Izq4Ejl+npCdIt+/11duS5vGssJBUI8MXsa44gepr2kYragsVGm8WipAfwISp+Oj
 vAFlf4FjBCF91gcN+czEOou1/76qQuJNC8Fxux7hhxSj71YLIxoUeWn8mIkHj+QpmFQD
 /u8w8QcNoYNih1PFtzScoH3XonSfYabc//SQVO0YLC6QiONFYRWknXof5cb4BCftm1P/
 6QrhRIhQ98/MMHItz93lzEBzpbzKywoDoxmqCP3TCRrCxyDHUYQcgOWj5g5gm5i+fdj2
 JRdA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz6qEV9taI2kOWadbn7A6b3qtt/AN3Q+P1zY2cKuFsMexlI6E8Ts9eTodhBjOz1koajPO2vQj89wy4a@nongnu.org
X-Gm-Message-State: APuU4Z+HyVfkKoj0pLh3+MgMu9AE48LlLyE+B4XIEMTwcguIhjFeK9VU
 QKiRr1NTee2IObvIqyVoxf78FWJzJySdfgjrihlARMnocxo8yAANQnWT24nyanPArWY=
X-Gm-Gg: AYBFou0nLty42kw2JJ6cKWLP1vbqVt8a1gfZvcIMRf42A98EvNHgiOL1tXHy+S1MOcF
 OGHm57GAy8NMJ0nyuwC0sM1gJE1Dz6qv2kMISuNHRNTiwIG2U0o6mEsYDN47dI7WP+sGu69WEhd
 244LdDY2H0XCFILVWwmYtF0j8qowzUTJQtUhxWXXIZdh2uUHAGXO6okwZ4lKyF+NL4F4/wsH/Wf
 z+h1++n0Cadn9lZryKmsFdD0Hj9PFsDmE//LnAAHx8pZtlaq0ByWYM/eWlAqKOaDfVOfT0V9BXt
 U0+cZXTzLYRIwvI7hYVp21RkUtu2/YjWzbLhQgc9+LuOooUJAs3hB2P5+iGHYFmHj00sy0S0BpL
 mjjmmgEw+I5XZ+CFUqyaTOFRJmhbPvLmI6rGP4UCey6mJo1UADhi0KBHujjA4Rrr5Nqo6SgSBqH
 gBhoAhE4wwnl9Wc9fuFhGdREFmRgosLPBUNI7r7glbLwxJ6UGd1uqiv9uMr9v+/ehlSOqMnBpp0
 TbuIdIEuGRfQ0G8JObuKx84AJN2RdbOpVCYcXtaYPJQnfTVWyhIr4mYCXZKb4yFB8dX3sVItOF8
 n2Qa0YFZWUT/uWk1RaEsRev3IvQ7HYFYcCrPuDvQFLkK
X-Received: by 2002:a05:6000:2610:b0:48d:ee59:3a30 with SMTP id
 ffacd0b85a97d-48e6e303b07mr36927626f8f.22.1793815909453; 
 Wed, 04 Nov 2026 10:11:49 -0800 (PST)
Received: from node-dev.home ([2001:bb6:1895:f400:679:4e67:67c3:4615])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda207d8sm4898222f8f.52.2026.11.04.10.11.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 10:11:48 -0800 (PST)
From: Weqaar Janjua <weqaar.janjua@packetfive.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Weqaar Janjua <weqaar.janjua@packetfive.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, kraxel@redhat.com,
 peter.maydell@linaro.org, pierrick.bouvier@oss.qualcomm.com,
 jasowangio@gmail.com, pbonzini@redhat.com, farosas@suse.de,
 lvivier@redhat.com, marcel.apfelbaum@gmail.com, peterx@redhat.com,
 lizhijian@fujitsu.com
Subject: Re: [PATCH v3 0/6] hw: Add Cnuas virtual devices
Date: Wed,  4 Nov 2026 18:10:50 +0000
Message-ID: <20261104181052.3125006-1-weqaar.janjua@packetfive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <10c48a35-82c7-439c-be8f-15b9dd89501b@rsg.ci.i.u-tokyo.ac.jp>
References: <20260929202358.725310-1-weqaar.janjua@packetfive.com>
 <20261016153247.1815153-1-weqaar.janjua@packetfive.com>
 <20261027080746.2468700-1-weqaar.janjua@packetfive.com>
 <20261027063724-mutt-send-email-mst@kernel.org>
 <20261029115735.2716219-1-weqaar.janjua@packetfive.com>
 <20261029134859-mutt-send-email-mst@kernel.org>
 <20261029194227.2735464-1-weqaar.janjua@packetfive.com>
 <20261030191556-mutt-send-email-mst@kernel.org>
 <20261031120516.2846639-1-weqaar.janjua@packetfive.com>
 <20261031135234-mutt-send-email-mst@kernel.org>
 <20261031185807.2866788-1-weqaar.janjua@packetfive.com>
 <10c48a35-82c7-439c-be8f-15b9dd89501b@rsg.ci.i.u-tokyo.ac.jp>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::42a;
 envelope-from=weqaar.janjua@packetfive.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 06:14:36PM +0900, Akihiko Odaki wrote:=0D
> I am wondering if vfio-user might be better suited for your use case.=0D
=0D
@Akihiko, thanks for the review and the suggestion. I agree, vfio-user=0D
seems to fit better. The guest still sees the same PCIe devices, with=0D
the same config space, BARs, doorbells and interrupts so that addresses=0D
my concern I discissed with Michael about virtio that device-specific =0D
drivers stay exactly as they are; also implies the device models no=0D
longer need to track QEMU internals.=0D
=0D
@Thanos, thanks for the note on migration.=0D
=0D
I will move CnuasNIC and CnuasGPU to standalone vfio-user servers built on =
=0D
libvfio-user and maintain them independently in the Cnuas project. Your =0D
comments on patches 2, 3 and 5 still apply there, and I will address them =
=0D
in that code.=0D
=0D
Pls consider v3 withdrawn. I will send a replacement v4 for the series=0D
with a single documentation patch combining patches 1 and 4 which=0D
reserve 1b36:0017 and 1b36:0018 in docs/specs/pci-ids.rst for these=0D
vfio-user devices along with a link to their specifications.=0D
=0D
@Michael, @Gerd, Cnuas needs PCI IDs for these devices as without=0D
PCI-SIG membership we have no other way to obtain a vendor ID. Are you=0D
fine with these two IDs being used for devices that run outside QEMU=0D
through vfio-user?=0D
=0D
Thanks,=0D
=0D
Weqaar=0D

