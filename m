Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B25F1C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 10:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmtH0-0003Pk-Fh; Wed, 20 Mar 2024 06:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmtGz-0003PX-M1
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 06:34:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmtGx-0004gE-D8
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 06:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710930854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=KZfD2GtsRpQoQV3qywW/tD3DFAaqViFbe0U8kllo6YgHg7+xi0SB0l6t4TUl8qi/EZQemg
 YZrDoxPoLsIJdpqNvY3gZo58gfJRiSB1g0dZJeywYyj9cAw/T6ibxMvxsSoOUJh/EysHXN
 xNPkoQasJxow/gPEl9OsU0F4DCk5i+w=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-MPhClSEIPviJIHYcv1TflA-1; Wed, 20 Mar 2024 06:34:13 -0400
X-MC-Unique: MPhClSEIPviJIHYcv1TflA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a466d8ad648so396667866b.3
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 03:34:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710930851; x=1711535651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=QLHZhQPBIWGR2l79AyZfTPScCxcRN4XI2NiF8g1sFZkcncSXgODPL3qeFGQdHjlJdi
 Fw86ai5k/tfRQLsFdGqEkFKabnDDb9hpaV0NCbTszM00arre245gsJ7VJKhTJxe0I0hJ
 jLl3T5Ls4A7HrJ3TfXvss+atAqe9kwdjkau6+cD+nmIJ3nlX+0mqsFjlPe2mSpxB6LFy
 osITZ/vDgVD1vM/PeoOX8dOymctDrWVWIeyg9rUVmWcnTEsamvWBuokRHKHmrogOraB+
 UbdawqkgRtaMsTgEIjKhHcal9OO2d0Elrwg246MhNE17OA+k852nylbQkN6uoHMEqmL2
 NN0g==
X-Gm-Message-State: AOJu0YxxJhvTif6elskkEC4w04zbaSKsouoZvCmfd/VwfbcoG1efKWXd
 +p7S0Jj6fVJjKysRSQelhXmq3aDMkHEAw0m+h10y+QdcSd+bV7IBMyLZz7nQzEQzbEa/Usn3th0
 RNKpwQVxHlAbuvbpUkwVhV/uNT/FK7TNK7wm7OQBlmjxR8hx0BvW2NIEAZBD3
X-Received: by 2002:a17:906:264e:b0:a46:c11d:dd05 with SMTP id
 i14-20020a170906264e00b00a46c11ddd05mr3925386ejc.57.1710930851294; 
 Wed, 20 Mar 2024 03:34:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGK/cRf9Ps0QNzeovSr2JcRpKI2b8Ff9I5B22GEDnKq6rTksEwtBtfbrTHO/JxT8Gor+D9C6A==
X-Received: by 2002:a17:906:264e:b0:a46:c11d:dd05 with SMTP id
 i14-20020a170906264e00b00a46c11ddd05mr3925370ejc.57.1710930850960; 
 Wed, 20 Mar 2024 03:34:10 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 be5-20020a1709070a4500b00a46a9425fe5sm4845011ejc.212.2024.03.20.03.34.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 03:34:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, xiaoyao.li@intel.com,
 xiangfeix.ma@intel.com, chao.p.peng@intel.com
Subject: Re: [PATCH v3 0/1] Introduce Icelake-Server-v7 to enable TSX
Date: Wed, 20 Mar 2024 11:34:09 +0100
Message-ID: <20240320103409.1048570-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240320093138.80267-1-zhenzhong.duan@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


