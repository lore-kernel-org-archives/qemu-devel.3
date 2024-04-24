Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F5EAC07E8E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 08:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzXrY-0001c3-Fp; Wed, 24 Apr 2024 04:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzXrV-0001Nd-4O
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:20:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzXrS-0007Br-Ry
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713946813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=etyFpTU1imkR9862ICMwiC+afynsXV4iCP9PfkaQqD1buwXHQhm0BrH0kCUOQ27NTjSEmX
 aoIRqRCVQq2HXyDUSaxbjJ+ZPjNm07WxpiYm4xlTXqJ/pCENs+23lflAQUKdk+0qC6A+dS
 2TrZgiNOnLyTGxfDuSSvrmiln+oqyco=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-a2K0GIjgNkW-FCXnsu6E0A-1; Wed, 24 Apr 2024 04:20:12 -0400
X-MC-Unique: a2K0GIjgNkW-FCXnsu6E0A-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a51c76700adso59504766b.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 01:20:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713946811; x=1714551611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=O8wwvIUnSpMXhXwvBbfzLiFFunKNFyHbGB97Gs6k6kOMtmm8C+PVArVUkP0wnXfSq3
 DmukIKsQEouMrhHI3YXfWgqNnj9CM4cQQg5ft0W/RozBmvJKJ4l7LLgKq6PmqTm4Ck/G
 hHfjeX0AhOnM/H+LHmt57Qny9FZc0V2b+Z1Fri/X0gBk4PC+gGr4VDxZSTXfsAicXsa0
 fnYZz7Ewa21BsKs0wTjeovVPXxHAGnFzh70kJOtylOcrSQDqzQ7nEcGi3GZnAI079fsf
 meVHV+xHxRloSNuQwrQ/C8JigarYRe/7Nw04E8WN5z+vfRgC0hEgyEBSlPu3Tmx6teIB
 vItw==
X-Gm-Message-State: AOJu0Yz+2bZsRS3NLiYFMxZ2km1uuudttg4GExWdiT5CrHlm+xjPmqG1
 X/GHi3351HKFvHaWD335Ig+X/g8KiB48xQS3nBCp+MMcYNUCveLMbPlmiZj1mqy2rTslZ2jsqly
 dXq2YcCQIaj6H4Q7z0hKlVp8kHolMzAGC9WvgL2aWBQTlcHOMmu/b
X-Received: by 2002:a17:907:7759:b0:a52:119:3446 with SMTP id
 kx25-20020a170907775900b00a5201193446mr4713851ejc.34.1713946811083; 
 Wed, 24 Apr 2024 01:20:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG23VqKGu9EFgzap8ibhE8CwgjUmk2FAvOSzT/EQdAywkGkSYEMydLbwmHCTi5H47mCeoBW1w==
X-Received: by 2002:a17:907:7759:b0:a52:119:3446 with SMTP id
 kx25-20020a170907775900b00a5201193446mr4713836ejc.34.1713946810767; 
 Wed, 24 Apr 2024 01:20:10 -0700 (PDT)
Received: from avogadro.local ([151.81.119.75])
 by smtp.gmail.com with ESMTPSA id
 h20-20020a170906591400b00a51d3785c7bsm8001597ejq.196.2024.04.24.01.20.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 01:20:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Lei Wang <lei4.wang@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, manish.mishra@nutanix.com,
 xiaoyao.li@intel.com, chenyi.qiang@intel.com, tao1.su@linux.intel.com
Subject: Re: [PATCH] target/i386: Introduce SapphireRapids-v3 to add missing
 features
Date: Wed, 24 Apr 2024 10:20:07 +0200
Message-ID: <20240424082007.76659-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424072912.43188-1-lei4.wang@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
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


