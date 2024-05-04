Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B7FC4345F
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2024 11:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3E2M-000638-8U; Sat, 04 May 2024 07:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3E2K-00061t-0h
 for qemu-devel@nongnu.org; Sat, 04 May 2024 07:58:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3E2H-0002HI-TP
 for qemu-devel@nongnu.org; Sat, 04 May 2024 07:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714823916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=CeT3xzoWSiiOSoz7YmMYCaWMqHwnKLv2hDRr8dwgzKsmTHMiehroANUaf+InPTS7EntjpY
 cSCmnfLnIEmp+mK8v8Ed7ut3WPHUU45+IBQkqb4r1XnBdTAxbGRAcb4Bd7PXxEJE6X/eAH
 zDV/Jmf5sc1gpLihWUB9PvPBQHMdUHM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-IAU9vBRuNGiI1HGdB5c5AQ-1; Sat, 04 May 2024 07:58:35 -0400
X-MC-Unique: IAU9vBRuNGiI1HGdB5c5AQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a599b55056bso24067266b.0
 for <qemu-devel@nongnu.org>; Sat, 04 May 2024 04:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714823914; x=1715428714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=iK0M6ofk0J3cOKGpdHpQrPL+wgqI2i2w2TCfhCjIQiysRMp973/MZ9CtWXSpnx5Ui4
 00H7NtUiff74MDPmQKzfK2eZ97nypBh/p+vayHmZp/jqis/hhiXzjVDxIfwcHQgCaJY9
 1WXlfg2V81OfBbT/qxYaR463RHVic2qvEk4RUbWmkrJBvRoSYGQGIfeCr4Kz5+tR5cz0
 VjLRFjYsvyBHhHiBUO9cxvSgjsjreskRi2IDBqXSK/BkCUuFJ4LybViW1t1HExbbGaml
 4XGoHoEhFQCFO0E92kH2evjuYbNgDsfCueQmxIYBjB8Fjga0g0CZ4BiGuzVZHQI/Bosv
 trXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGdXD0wGBD8GPqONixgjPtz8J20Fgm0pBqaOF31BDQT9iCVMx1fs4erg26eg8jUrCqGC9UShlu1YmD+3/p+FQHpZVQwBs=
X-Gm-Message-State: AOJu0YxF0Cd5LxICkWYqxvOlxdybgsIs9lOTxddlISE60HYiQG54iJMA
 YYEOZurvuh1jONdnwnbvaoqXyAHrmoRuNe7zOiGbB80O7haCd0rEOe2xauNUQEorUq3kc+IQrNy
 WnCeiQdksJjaX8/QBjts2Wzih4sKN/oHmfD9ilu6LAdhEC8aFFhdt
X-Received: by 2002:a17:906:b798:b0:a59:a221:e2d4 with SMTP id
 dt24-20020a170906b79800b00a59a221e2d4mr1220957ejb.8.1714823914291; 
 Sat, 04 May 2024 04:58:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHivvYPve3H8clYR5gbenwCsFp6g++Cb1wD6BiFPnCfzvgcvVOgLA5NWdqm9kKtGlzhIjFGmw==
X-Received: by 2002:a17:906:b798:b0:a59:a221:e2d4 with SMTP id
 dt24-20020a170906b79800b00a59a221e2d4mr1220933ejb.8.1714823913871; 
 Sat, 04 May 2024 04:58:33 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 jt21-20020a170906ca1500b00a526e6f5cbdsm2850731ejb.47.2024.05.04.04.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 May 2024 04:58:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, weijiang.yang@intel.com,
 philmd@linaro.org, dwmw@amazon.co.uk, paul@xen.org,
 joao.m.martins@oracle.com, qemu-devel@nongnu.org, mtosatti@redhat.com,
 kvm@vger.kernel.org, mst@redhat.com, marcel.apfelbaum@gmail.com,
 yang.zhong@intel.com, jing2.liu@intel.com, vkuznets@redhat.com,
 michael.roth@amd.com, wei.huang2@amd.com, berrange@redhat.com,
 bdas@redhat.com, eduardo@habkost.net
Subject: Re: [PATCH v3] target/i386: Fix CPUID encoding of Fn8000001E_ECX
Date: Sat,  4 May 2024 13:58:31 +0200
Message-ID: <20240504115831.290599-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <0ee4b0a8293188a53970a2b0e4f4ef713425055e.1714757834.git.babu.moger@amd.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.23,
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


