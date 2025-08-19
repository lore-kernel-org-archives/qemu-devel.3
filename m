Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 310DCCA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 15:34:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoOLa-0004In-37; Tue, 19 Aug 2025 11:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uoOLW-0004IR-LR
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 11:33:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uoOLT-0000K7-Sy
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 11:33:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755617634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uWsHmwgZGCCReftr/hSFmw4uLov4g/bvVqu1H4Uip0o=;
 b=Uk44tC/G8g4erFi5kcGBep7ycY0nJdWOqJ1iN7DXtTsSmB7dny3nzUCU76Vkj8Rl7JU5gL
 pdpuuvbSCn0i/Hfs3o4Z5gW6NLIr+QunOwHMpcDl6JVXM1e003ea48KwMQPTEKvJe1xujk
 sgdbxnh6RqV5APtOWzCpZsnTB8+Zy9I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-texerqpKO32bzAt6DT3rAw-1; Tue, 19 Aug 2025 11:30:52 -0400
X-MC-Unique: texerqpKO32bzAt6DT3rAw-1
X-Mimecast-MFC-AGG-ID: texerqpKO32bzAt6DT3rAw_1755617451
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45b467f5173so2383295e9.3
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 08:30:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755617450; x=1756222250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uWsHmwgZGCCReftr/hSFmw4uLov4g/bvVqu1H4Uip0o=;
 b=cecr9oGCv6i22zE1q/qtae7NRsQQh7yepC5TaII4FPeQ01UR4AvyWIaOyB+kjXsKdM
 AsOykPTYL92w9AIC1t4ytQ0sKIoQ3dEVrVahgJRFOAViGuPVmhISEUd1ArVG1kNeViwe
 4Oc9KHL3uBPIBl6SVlI3alARzso23VJhiNhp1ySk3zWygDUvIW5Tzjq+dkSxvJbCjXVR
 ENI1Zd22fgpFN1KBiFLljNRg507enuTXBXNVEPo4JPtiwol0GOM5KMu6zkN1JqSobLQE
 NAKNGBN8HQuAA6UyS+TTTMSPqn1+Iqkex64zqAPfEwt4ub34EdyBDhufi4rPBoIe2wsM
 CM0g==
X-Gm-Message-State: AOJu0YwF965UWqVYnD1983MXPhoYO6Gx58DPCcP0n39K7E8sVBz9pEtp
 0qSYiJO7CTzHHZz0WCVoJQoWEl/ohQ5yFCeec0Ss8lrYgEzZX7uVQC+G+PaI/XUazbTpKMXIjRl
 1uL4CL+xStqJiThbYe9VdSzeyT8lHk5v/vaAAe20FQN65epHJSReCFng95DHx1jszMBVvdisVeJ
 qLkiVBixCEZdnJKRP+JUoKnBZZ6c2jNx+mE82DjVjy
X-Gm-Gg: ASbGnctz1FanluWP1pmccw6lb/xzWcOJM3f9l44P6ykcK0U75UQqTZS7Ov+i2Ib/tM0
 Pu8F4q+CsXWK6czMObhinYMSCnqAx0Ydk3iNaDCdNvYx+G1CkQx3+tPbbHH1mx2SuD6V1FJXLKT
 rATt3+4i3IbGcBz+fDpf9+In47E/N5A1m9o2PsnPC746IPvzJ3rRdV0/2zF/mKzSTec43iJMjZY
 7GAdQyvhXEaGQpQGk4ZwzkzC79li/GVc3lx+HQYSEMyHrUtYblRZQax9vvXTvw6J3z5G+mjtfCT
 y3+y5JLn1j6uuLxdsp6h3GntAPIsCqm4ieM6JdUBdw==
X-Received: by 2002:a05:600c:3505:b0:459:d3d0:650e with SMTP id
 5b1f17b1804b1-45b46cf0388mr4576785e9.13.1755617450130; 
 Tue, 19 Aug 2025 08:30:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4nkoaIPCDs+gl6L95jqyq5x0fW1aXXnik9aoZztPeBEJ+IM/tvfbUbGA0+CGb/h9puSRBHg==
X-Received: by 2002:a05:600c:3505:b0:459:d3d0:650e with SMTP id
 5b1f17b1804b1-45b46cf0388mr4576425e9.13.1755617449651; 
 Tue, 19 Aug 2025 08:30:49 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b42a7756asm44385545e9.11.2025.08.19.08.30.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 08:30:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Wang Xin via <qemu-devel@nongnu.org>
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, weidong.huang@huawei.com,
 WangXin <wangxinxin.wang@huawei.com>, Tuo Xie <xietuo@huawei.com>
Subject: Re: [PATCH] target/i386: Add support save/load exception error_code
Date: Tue, 19 Aug 2025 17:28:18 +0200
Message-ID: <20250819152817.789959-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819145834.3998-1-wangxinxin.wang@huawei.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Queued, thanks.  But please let me know what's the correct signed off by chain;
either Tuo created the patch, and then you should have "--author" for him and
his SoB first; or you did, and then Tuo's SoB is unnecessary.

Paolo


