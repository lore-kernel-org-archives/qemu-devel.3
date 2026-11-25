Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520A0606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 17:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FopnUpMX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWH8R-0003Hy-Ip; Wed, 25 Nov 2026 12:50:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haseebashraf091@gmail.com>)
 id 1xWH8J-0003G1-4I
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 12:50:16 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haseebashraf091@gmail.com>)
 id 1xWH8H-0004RE-G0
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 12:50:14 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4bb6886d30aso58082975e9.3
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 09:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795629012; x=1796233812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5p6EFOjA87jcLwyx8NSrFxBVW8rVsjMVihvg88PSe5s=;
 b=FopnUpMXCiCWXzpQuHWfENIneC4darCcS6FEfff9MK0/Tf+Evw2vK8WI93/e77ufzd
 C0VFeZGLTPzo2NO7xsbcfwsRy2jkpHPoSX5dOvvwOI3FDxyK31/6f6iA/PDUHYL18cFn
 ml6zTSGiOl9HgPxytFd9cYbFFTab5YCQ23M3R12aj+wEf70x9iMRB5BI7bn6awLGlRwU
 FXqz2KSb/T7cmHWuEdbbUIlX9jFB5U5poq132uVyyU6+CWdjsulHx7XTPQA0RG4dDpY4
 hl+HeBS2dAFpQqqm5uLnlX6qdJ/GFDmHqDgFw/I4e4CXTxRG4nKfEmGs5t7PHpL5r8Vt
 GgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795629012; x=1796233812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5p6EFOjA87jcLwyx8NSrFxBVW8rVsjMVihvg88PSe5s=;
 b=ud7u+atMLABP63LHXzzNUBtjGd6aiJ0xJRZfQbr7GnEeXDxLTZIa86ZD1Bpxiwvs94
 1PX9SkCHga+7tB+c9zWJPSVW6QuwZCaDZt1lCwaD+n9yzHl7QhDnL/tZYCf8BdZG8Jl4
 EYuekUfhItNcNku8ups8DpfUod0e8Cs8eu0pEXvzoN6JtL63OaPU5upZ3Nf69rAvNAPS
 DDyDaeaKhYMNjBB2NVInbUcDmtyR3RL6kQ1aHVt1AMqmCuIO9/txkjbXcZtkVprv5afC
 I63xOfaxJK98TaOhpxmYUo/QntzpV8359DbfQMKvWV83DCW0oTxb5PdiMU00etwM3yyy
 lzMg==
X-Forwarded-Encrypted: i=1;
 AL+hErGL1FWxmapG/8hdUOA+SnSS0gbSFeQk1oH1QI/X6w3Avd6uLA207Ur5WrJKIOvR+X4D0ImRxv6pbxxx@nongnu.org
X-Gm-Message-State: APuU4Z8Vaz/348u9xxI0KbcMTLPDahVdGlx8aTrVZb+QywE9R0NgYy46
 tN1/RowNtMF6MRcKY1EnPYB6sn7q/ZhZvpzRKH8XrdJ1A8uBDZfbgdZn
X-Gm-Gg: AZFdTZcj3lxOjHqIw9YF7HbaI9IIwuL+9s3XNXHk9TWFP9GRUEFIlRfldpBS8e/eXGs
 EtbHbVQ61TzsfmmhPkqFkUqmBHiUB14BcaerhVYPkFlNYqUQkl9pGuvDdplEJwwl2uoMcFDlxHr
 D7a0xuHORcHhAmuXIIEszYb2rHJ4IKWmT3dehAFBd5J66Y0Ivn0bN4Ze2DTaaW5FMXxSaPeQrFF
 3yVcrbIdPy5AN5sa3qhnccU8C3Y/Ipy3l2odAOjvjN83VxBoOUr1Qpz4LNx8WapyPJiUudeJE9w
 uwSjBFw/ohA1UfjSVIlxNWh4e1vGXOLmPaSGsSMftoFNohJMvMhkAWIShwsn3awACqWE9WDflTE
 qwhoFwyMMK+Xy+Q6+Yu2GIZ6ngz5CZZVe8kGMDjyPOOSl95B/K98pPmig+tTaqbv1iR7gRKI9/J
 Jl4iGKFKCvh/3lmcEFzRtHAEiQml3Ibsn5Qa/gOODxOVbSmcupGbfLxGXqQ4bkbA+f3wPvEL71J
 T4yjshJTmjT3EkMNqe8B8yp5QxnTKalPqRUt0eWDRHP9CkomLB49M7REB3SYKZ5rwWoXUy4Wzfd
 3Z24RnTsELvKitGRLX900SZsEx5TeQcJ4B3hnL8Q3lP3YLGfpgdiykEXmclNvgI/OcsW5CQfpYS
 hcPaOnY0xcyQnkYHnCWSJORc7
X-Received: by 2002:a05:600c:83ca:b0:4a1:9661:14b5 with SMTP id
 5b1f17b1804b1-4bb888176eamr378604125e9.29.1795629011682; 
 Wed, 25 Nov 2026 09:50:11 -0800 (PST)
Received: from PKL-HASEEBA-LT.. ([39.36.25.192])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb906cdcc1sm301652845e9.2.2026.11.25.09.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 09:50:11 -0800 (PST)
From: Haseeb Ashraf <haseebashraf091@gmail.com>
To: Eric Auger <eauger@redhat.com>
Cc: Haseeb Ashraf <haseebashraf091@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Haseeb Ashraf <haseeb.ashraf@siemens.com>,
 Eric Auger <eric.auger@redhat.com>, Marc Zyngier <maz@kernel.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
 Khushit Shah <khushit.shah@nutanix.com>
Subject: Re: [RFC PATCH v2 0/3] arm/kvm: select an nVHE-only EL2 with
 SYSREG_ID_AA64MMFR1_EL1_VH
Date: Wed, 25 Nov 2026 22:50:05 +0500
Message-ID: <20261125175005.805533-1-haseebashraf091@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <63fcaf35-5d3f-42fb-868f-9fcd644bf494@redhat.com>
References: <63fcaf35-5d3f-42fb-868f-9fcd644bf494@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=haseebashraf091@gmail.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Eric,

Thanks for the feedback.

I agree that exposing VH as an exception is appropriate for now. KVM
does not expose VH through its writable ID-register interface; it is
selected by KVM_ARM_VCPU_HAS_EL2_E2H0 during vCPU initialization.
Keeping this explicit avoids prematurely adding a generic framework
mechanism for which no other field currently has a requirement.

On the second point, my wording was imprecise. KVM updates the
guest-visible ID registers automatically after vCPU initialization, and
the guest sees the derived ID_AA64MMFR4_EL1 value. I referred only to
QEMU's cached isar.idregs[] copy, where the framework currently deposits
the explicitly requested VH field but does not re-read fields derived
by KVM.

Thanks,
Haseeb

