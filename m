Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DA3C71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 18:02:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRad9-0001H9-GF; Tue, 17 Jun 2025 14:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uRad2-0001GQ-Os
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 14:01:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uRad0-0002cF-Jv
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 14:01:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750183301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q9kbptDbbcF1ZiyC3vZ0gv8Vd8d+DrBSojBPq/qi1Zw=;
 b=LrDuJvzK3D/qQYsjaeKoRdEGRdZhLJ5Dj9+EUgTjNqiuQ0GiNPPa2CXyGogqmExjQ2ceHM
 NgJ0Raqh+BhRed7E7dYxAZy5jHoUBl1zojxUsQShk3CcToKG00aOLaHYo5VUep/ZGaBNo7
 ayXQ8mLxyI1fDQdQQRxJFjYCFP7dCII=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-wFF8GyanPKyKsKCeCrJzAA-1; Tue, 17 Jun 2025 14:01:34 -0400
X-MC-Unique: wFF8GyanPKyKsKCeCrJzAA-1
X-Mimecast-MFC-AGG-ID: wFF8GyanPKyKsKCeCrJzAA_1750183290
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4530623eb8fso43014755e9.0
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 11:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750183290; x=1750788090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q9kbptDbbcF1ZiyC3vZ0gv8Vd8d+DrBSojBPq/qi1Zw=;
 b=rD81hulh5JWE6dNUqMZdME52ac1bq0l3nN+UVMK4ms3r+0wWOhDLUfbpI8erORAYIa
 yEQUztHZ99y7ThOVVSIX+EaHzdIX0mK7o14+1nRbf2T798jlR4Y2e+AOjFLe9NSpywPi
 h8w1VzeYVdA6nYCwT+mUQbiRGtw/yH2ZecXq+Qb573XA93VGoeRQ5LtpRQ7L5bVhgR3D
 wOXrEqJmTKrGMIoAbEfv7e06T/IvKWrBYe4tIumvA1Jlscu2lq3OMr0xEY441VpZ24AO
 vRBScBqbFiwF2Nyf7gpyyNfpkupVGlTCVtx6Nbnz7Lm2G7ofWs5J8m2R2AoqaqYiYJck
 fcJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyRGvZUCm7b5Cw1l2GFhepanublBAystlm4y/rZMYqH2G9zutG8QO+04yZdrC9Zwp4aoG/fZEIDnSb@nongnu.org
X-Gm-Message-State: AOJu0YxhCoDWr4sxkRfDwgh0ivaL3A3AO92AkS9HnEFH9fg4pwK4JGmR
 ARJJHCNvto6+QUfAMtlme8QjxGSehL9a4VCI6JnraaJiJBJDhSf1OKunr+IeIbiRNpbk5m30JMe
 rju0FJhtWoVkc3+UZNLAzV3/drDf8/IwixzqOxdzBtUg80Pq86erFFoSv
X-Gm-Gg: ASbGncu7rfryc/upGDI64wP/Ra+TrJgFsZxXphRhu+0MxL9LBOQbTrv9BLbeFJ/c9QZ
 3aazQm2HYW9f4Sc0XAmpoVP2OuWkLn/A7tK01GMxSHe4R9FJ1iw4DzSLDUWjlga46mIfDoRVqlY
 UiVCPVqA63RaRFAPLQGV9LN+fzJpo/koO9QEnZNr8oMVetqD1VdRDcfqEtA3TQqaVqLmqTX3IB6
 fgjMJTNF1hYpD/R8VfbtDnh+9+WRgHuJQtLsiB3CavlYyqrFCQB/oRqMFK+0IzDdONKSz61O1L/
 o2vTj0tyKfep9keZ3MhDlV2FlTs=
X-Received: by 2002:a05:600c:1c0a:b0:451:e394:8920 with SMTP id
 5b1f17b1804b1-4533cab8564mr126892575e9.27.1750183290226; 
 Tue, 17 Jun 2025 11:01:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/zMn3exeeuNhJxJDBQQGoxiK8rL5m8Yo9UI/zZkTv3t+2EcPZ445LTVKwuKURx9OwxHMVQQ==
X-Received: by 2002:a05:600c:1c0a:b0:451:e394:8920 with SMTP id
 5b1f17b1804b1-4533cab8564mr126890665e9.27.1750183288220; 
 Tue, 17 Jun 2025 11:01:28 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.88.147])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e261a72sm181421335e9.38.2025.06.17.11.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 11:01:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org,
 Dongli Zhang <dongli.zhang@oracle.com>
Subject: Re: [PATCH 0/2] i386: Adjust CPUID_EXT_PDCM based on enable_pmu at
 realization
Date: Tue, 17 Jun 2025 20:01:20 +0200
Message-ID: <20250617180119.269932-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250304052450.465445-1-xiaoyao.li@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Queued, thanks; sorry about the delay.

Paolo


