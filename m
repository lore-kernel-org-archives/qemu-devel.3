Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910DBD216A9
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0iIP-0003Wl-Ct; Tue, 15 Oct 2024 10:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iIL-0003W5-Qw
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:13:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iIK-0002nP-F3
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729001582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=M/fDxk2mr6I7ffmk+b0OItSTPJ4SfUFhVgItHMimu9NiamYsttQjwGXJiBrJyBjvKYaPHT
 gqHuPSO1lHEQ6/3U7XM6OJkdSsfb3vfdSi61ogtDZX7iZy9IgE20/RAajw4p/NsHBEG8SG
 GosZvmNJrmIhRC3HD7URmQWaR/3/Nqw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-sTy-5MQgOweY46j0hpQBCg-1; Tue, 15 Oct 2024 10:13:01 -0400
X-MC-Unique: sTy-5MQgOweY46j0hpQBCg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-431123a6eb4so30435475e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:13:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729001580; x=1729606380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=JCTi7w2RBCSqijbsRf+IMtvyrN55+3fe+KoF3InfWd6VfS1/qMRidLdISWxiyLJw0i
 nvUvUlnl+ka/yyCgW4A0TybE6P6gRDbnHbkX6RXrMvf8n1Y1xVpR7ax8cDcN5znoaVph
 UeeNaMNUAe3MW9vL3whZVEzD1z+VjWiGR0+3T/oOvin3pH4YqkfcIdPglDbyha58Wa96
 zktvBqm9D8Uer75qKcjQ1Rez7vGgwUqJUZQNeG3yLm/kFWE50j33UYyz9hs1AGFnb3V7
 m+yTAwjxHvyZecBlb6XfiKdmEdHfeCZvpMBAyLEgLo1NJ7pla4t2lVv5GocruC6V0IPz
 mnhA==
X-Gm-Message-State: AOJu0Ywse6D12JjIBOPZTqtFn+po+ShYrumkbBn7InQ/x6swsWBTmeLu
 Te+9NnkZ9oXXb8SnTpE2VJHdEalsOCfLSDIFila0Ucg+J3RzXUJh0Zj7pRw1aUWthj71G3FHCVn
 hQKB4iq9wjKBr80YVkumjbhoL0DydbHtKxBWP+r8j3AHiW17MkvOC
X-Received: by 2002:a05:600c:310f:b0:431:405a:f93b with SMTP id
 5b1f17b1804b1-4314a31f943mr7034765e9.10.1729001579752; 
 Tue, 15 Oct 2024 07:12:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAbQSLwPH9VQbboxoLACwC/+Fpj7EuzR8ydXcginQFUXUTA5HYDnG2Q2lVCchEZcT2ArZpcA==
X-Received: by 2002:a05:600c:310f:b0:431:405a:f93b with SMTP id
 5b1f17b1804b1-4314a31f943mr7034515e9.10.1729001579387; 
 Tue, 15 Oct 2024 07:12:59 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f55dea3sm19643055e9.9.2024.10.15.07.12.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 07:12:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
	pbonzini@redhat.com
Subject: Re: [PATCH] target/i386: Use only 16 and 32-bit operands for IN/OUT
Date: Tue, 15 Oct 2024 16:12:54 +0200
Message-ID: <20241015141254.527325-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015004144.2111817-1-richard.henderson@linaro.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Queued, thanks.

Paolo


