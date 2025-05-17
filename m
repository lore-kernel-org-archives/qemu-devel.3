Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A78EC2D0CD
	for <qemu-devel@archiver.kernel.org>; Sat, 17 May 2025 14:30:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGIXh-0001WP-8q; Sat, 17 May 2025 10:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uGIXe-0001Ub-II
 for qemu-devel@nongnu.org; Sat, 17 May 2025 10:29:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uGIXc-0003LN-De
 for qemu-devel@nongnu.org; Sat, 17 May 2025 10:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747492168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=GDQMuI/NncrEaAv1JwC0YR97LH6dOOp58bbQmbpnxGqXMfd8V2Y0rVsSXnwTZ2LmRhCN6t
 7QJRJvI30zmKlUFY1OngZOSos9iK8p94aWBzeM/KusGpH2knT3wFnv4SsD2k464qrn1HgF
 Vf7AmWGxZH+Huf73KRMGbEr+R50S8MY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-97dv7ISmPNe-zyFoBbOF3Q-1; Sat, 17 May 2025 10:29:26 -0400
X-MC-Unique: 97dv7ISmPNe-zyFoBbOF3Q-1
X-Mimecast-MFC-AGG-ID: 97dv7ISmPNe-zyFoBbOF3Q_1747492166
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6f6eee4d7f8so76230816d6.2
 for <qemu-devel@nongnu.org>; Sat, 17 May 2025 07:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747492166; x=1748096966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=aHNMasB5/rJ32yXKwmHxoFGbseCOMmP5jY+pt9t6CUp/wfF9x7ib5MMkz2DCuhgW1m
 3M74bVc3lWVNgpAC1vy/Q2X8Fho8tmEzsMwu4/0+U3rX+rWBpBCXWgbVpvti2cCYWvEA
 n8INOZCd8J7mDYhXY7ijpHPcQBrTuBHjMiQqQ5/6Vg0dCdmVvHLTTwrYKs8ALxk6pFMk
 el/vjtmJXEi7+tLeO9xSWMoGJaOblaG4UmsyccbOH4ZtMWyRGEj1kKeTAJ/JFYCWxHAq
 XMLhrYBAlHPkmglz8C8isNyy+JjtPyQRkd7Cr2OmbvnU3Yc1Z1r5ROTe7P0Nr1vIQpbH
 1dZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEoAAuYvcQjk62JHQpbioYIx3kBb7qT3gNN6zI4XoOi83501QWL2z8vsRQoLseZP1TUbAa+Laj6fyp@nongnu.org
X-Gm-Message-State: AOJu0YxEXZ48WILEFf/SvQYYO6uayGggj+pWFHMpforhzYZUMnTRHWwg
 QPvUh2TZACv4JRelLos0rmqbNoNf6fwzeLTGBQXAId+aryKaNLfXgJG5cPhK0ZqeSczI557oF8E
 cMn4NtAZSDYFG5AL9l3Ld3CdjcO7YgeU7TfLft1Zf7rFiqlhASUPZIQQw
X-Gm-Gg: ASbGncsDd1otiKFuXZ5OQzNAkcNwfxd2YHX9w9G6UlukQyeTC+yYvXkbZbCQGiIqo1G
 XVyq8tlZsP/CUVmuc9JfJaxIRRX+tmmG6QDD8wRf49Jsx+dPYsOMZe77AvEasI3JmdQ+qp/6izm
 UV623/b/UJVXW29M12aZR24gihj925bUfaX6oXe57xjIDhaKupwKeZbY0bOX+FWuU4RQZlW592x
 CxtKQHE8yVT3iU2sSGMMM6pgWWx5w4OblM0Pq/+tXr+BfsMrqp2zcv2e/d9VSBUdlNL9DbbAYq/
 rsiQkMl5RFMHxRw0
X-Received: by 2002:ad4:5948:0:b0:6e8:8d76:f38c with SMTP id
 6a1803df08f44-6f8b2d2e1ccmr98671556d6.40.1747492166245; 
 Sat, 17 May 2025 07:29:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXM31v/lghkZe3Oav1MNYwaf/aS7KxTncSg5dsKggs3mDtiX09p0wFCdTbUuu4Z/gUmDyaXg==
X-Received: by 2002:ad4:5948:0:b0:6e8:8d76:f38c with SMTP id
 6a1803df08f44-6f8b2d2e1ccmr98671386d6.40.1747492165995; 
 Sat, 17 May 2025 07:29:25 -0700 (PDT)
Received: from [192.168.122.1] ([69.164.134.123])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6f8b5a2e3b1sm19611006d6.65.2025.05.17.07.29.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 May 2025 07:29:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 0/2] qapi/misc-target: Rename SGX related items to follow
 QAPI naming style
Date: Sat, 17 May 2025 16:29:23 +0200
Message-ID: <20250517142923.374486-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250516091130.2374221-1-zhao1.liu@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.616,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


