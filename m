Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E203DC25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 09:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9i9G-0006q6-58; Wed, 22 May 2024 05:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s9i9E-0006pu-Ch
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:20:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s9i94-0003vi-BP
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716369625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Svma0tIUpaCFHm7Vu9JNy+wWuWzv2Yl3bgqD6JJQLgvgVVuBEMR2fvOU1GCAWdiBZ7WIji
 PoyujUJ1g7sM7WutMZh4fxEtGDu01Y0i1gsa7Nae9YYneQD76ujHT1jBxn6gsWInYwM6ox
 3FvTnnT3CwrhkPwViersxqZt6WFZYSk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-CBZqBepuPZ6_wBI5JGPztQ-1; Wed, 22 May 2024 05:20:20 -0400
X-MC-Unique: CBZqBepuPZ6_wBI5JGPztQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a59fbf2bacaso51175966b.0
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 02:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716369619; x=1716974419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=SqEsjoTL1zPhXZ93G64Mki8FFVMop0MppK1JJeeJcwtNm7sNH3erbfkC1neWRbE7zR
 3uTt0O4dlkGJr2gFp4ScBHKYZ9hrc831QnkwczEsovWjwSI2/27Qkiv9WMlF+dXBYwbH
 mt8d7g5OVdS4NAA9k7AFM3IvA3iwTRdPmBWHFLsBjD17Jh9cTyLqP61/QsuGmFw5l1Xk
 Y7Uy2PGZLx3oNao66O4FMr1MDpWBfzT++BZyR1sNM842rUWPRMOt8tb5tN4DfXkiaLv0
 HRtkveM5bpRoYUbJwNa/zsEGmvDJFMTsZIQMDnLpe116sXXmoSuBh6q2mSnWwX+k3WUc
 h7dA==
X-Gm-Message-State: AOJu0YzzrenxADm5r0+ho/k5mZ/ORfqWBSE43dor8FvvuYDeGbfmUm7K
 G0iYEjhpxM+gP9hc1HCUkKzopqm6aTwxR7spQoDYkjhXm0WtNWXSDRSYGn1Z3TEyMnyLqUtUdwz
 eQGZemxDym3INKb3VpFDqrG/qOPPXaHYHASFKcOqHQOl9mqNSKTX8
X-Received: by 2002:a17:906:3455:b0:a5a:423:a69e with SMTP id
 a640c23a62f3a-a62280b0b82mr127044966b.15.1716369619483; 
 Wed, 22 May 2024 02:20:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYPcVfPSbkAXS68vBqRtM1OqnF0XUIfdHR2qup5zLEObWYFFmu64efJ42K6olXzXuLrAmeEw==
X-Received: by 2002:a17:906:3455:b0:a5a:423:a69e with SMTP id
 a640c23a62f3a-a62280b0b82mr127042766b.15.1716369619066; 
 Wed, 22 May 2024 02:20:19 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b17f37sm1746100566b.224.2024.05.22.02.20.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 02:20:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 xiaoyao.li@intel.com, chao.gao@intel.com, robert.hu@linux.intel.com
Subject: Re: [PATCH v4 0/2] Add support for LAM in QEMU
Date: Wed, 22 May 2024 11:20:16 +0200
Message-ID: <20240522092016.568512-1-pbonzini@redhat.com>
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


