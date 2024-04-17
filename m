Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7678DC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 09:09:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rx1H3-0002cj-Dk; Wed, 17 Apr 2024 05:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rx1H2-0002bb-1g
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 05:08:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rx1Gy-0007E6-9O
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 05:08:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713344886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=KAXOhBwjfVJcEAlUtSSuh7fjgs08OegDzUnYkLo4w1/CfnmyhAYFFD/3zvVGpyxzNYmwWv
 SjUyR/Tg5MZhP8BFYFSa40nbcpc2HQvAFNPzWhGrDtKr7d0E1QI8HZP8watkjTVgOhPC/A
 9bop5akSNTGT1odhzFi85pxM69um6kc=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-QrID9b5fN6Kjn5HXMJZgBg-1; Wed, 17 Apr 2024 05:08:04 -0400
X-MC-Unique: QrID9b5fN6Kjn5HXMJZgBg-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-516da5d2043so5035903e87.3
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 02:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713344883; x=1713949683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=i6a3N0nyKoGYSQgYz9kUx0mr3M6JMBE0z1FYtDYXOVNzGcfCdAu47sove8V+9BoJbU
 QyNF7B4GDDGYFVbpGE1YFcAdZTT4lTHBh3OCEfE3+E/kk3c0MuUtQciU593MRYT58F0j
 HxkabzHqd9MrrZnHik3DTNckqvCsojCw+7KaxnzZgJsVaKgSt/0obZpe53IYh8HI4hfg
 zcFE9IH4d/4rgFkxwMgCGZcUXEnpg1a17u9JBQUW4ZQHD4P/EUBR5YgjYldv6WXUyqYk
 ETLwd9TkdWjOgWkKisWm98rVNDRplLi88ai1iMVDH1oHEVpnrp4+H+DI+UBt5h2ALUgv
 4mqQ==
X-Gm-Message-State: AOJu0YyfUoerLmOAOCDd4CELz4wQScyTKN2+D1P0GbwfHz5rXyF5bAfQ
 lNxueM8r2ENNos8+KgVNY5pdoNUkI3A4Y/k04W3JPUcAmqZibUJ71YlPNRA2pvsWS5o5QOfyerj
 de0OGY7d13vsczq7xUGQhtfdDkOcbkPUrElYn6N3RUQUXR0KMMNTSwGWTKq+k
X-Received: by 2002:a05:6512:694:b0:518:e2db:4f8b with SMTP id
 t20-20020a056512069400b00518e2db4f8bmr9027469lfe.37.1713344883120; 
 Wed, 17 Apr 2024 02:08:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsJ1esffExV5sRtYhfBw0kNL/l6z5eV0McRGdahjcSD/GfBoDpjsI/5RVqpp79VgP9f9f5ug==
X-Received: by 2002:a05:6512:694:b0:518:e2db:4f8b with SMTP id
 t20-20020a056512069400b00518e2db4f8bmr9027446lfe.37.1713344882724; 
 Wed, 17 Apr 2024 02:08:02 -0700 (PDT)
Received: from avogadro.local ([176.206.84.58])
 by smtp.gmail.com with ESMTPSA id
 jw10-20020a170906e94a00b00a523be5897bsm6476812ejb.103.2024.04.17.02.08.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Apr 2024 02:08:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 0/3] target/i386/cpu: Misc cleanup for warning message
Date: Wed, 17 Apr 2024 10:34:06 +0200
Message-ID: <20240417083407.1811888-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327103951.3853425-1-zhao1.liu@linux.intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.844,
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


