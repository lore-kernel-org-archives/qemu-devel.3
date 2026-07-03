Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99709C44500
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 14:00:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfeRG-0000lA-SY; Fri, 03 Jul 2026 10:00:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wfeRE-0000kh-1L
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 10:00:16 -0400
Received: from fhigh-a2-smtp.messagingengine.com ([103.168.172.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wfeRB-0007fS-ID
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 10:00:15 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id BA90714000E2;
 Fri,  3 Jul 2026 10:00:07 -0400 (EDT)
Received: from phl-imap-18 ([10.202.2.89])
 by phl-compute-02.internal (MEProxy); Fri, 03 Jul 2026 10:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1783087207;
 x=1783173607; bh=s6ihjSqAX7xyUDsJ64xKNNvnkLFajk+lAHKOX2LdLmQ=; b=
 Zs0biuWD3yYZsFpA67EKL+hAoz8YLRGg42q2J5/8FVqwDCmfJu83qrot9Q3I89Re
 pq/aDtUX1uGni1GVxFEfrFf+mqRE/fo4T+BvLVTESYG+AXiuhQ91wcjwtjQWCqUo
 LcHgh5MTF7htNkQ3yKB0Co3YSwOWFWQRPo4VgvJy5i5rHxIAAakMbU86TmGpVRYK
 vFy/SbcCJM1VOPRWO3nW02fvNyf289qyfjjoOc89q9qTBvxbBwvkGDfGZUyQm3MH
 2IfJcOGyLdKWwMoRdK3rUfokikkF1B5IKc9aO4aLx7uaR/XHhIU2vJzJ4J+QE9YT
 k23aAfacUkoOLlMvcUatEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783087207; x=
 1783173607; bh=s6ihjSqAX7xyUDsJ64xKNNvnkLFajk+lAHKOX2LdLmQ=; b=L
 JTyJV7MYWnA5FFIkGTUk5TcwRsQC4x3B78Q3SGUFWQkPczVR+E/TAO3DEbrz7lpa
 XIRt5AtgxMr3l0rcXSR/Za1i7iQ8ewY3j1T7PvLUmNS8TTLeBXRwaoni5S7rbung
 Tj512OzBGjtRpl+AxKQ5oIqW315vyN3DO8QD0v+hDtD8LCR2Btj42h4FzkxUwBXq
 1UvpRf/LcA8dfHymdfeI7eh/+/1U9klgU0WLUP3M4zsaAWeYRMcc1WWE3qLZxzM4
 Yf47AuhNav9pEBaliEM2ZY/n9jUHca/dfvgJiiTqHyzC7WnoZSb7RFI3ALZGp+Kz
 8jbVoiTKoAGB/vsY1xvVQ==
X-ME-Sender: <xms:Z8BHakmOSWZMM6X9VoygTPGxjVV7eqAUf3BrQv_2XI7LIdf8ywH5kA>
 <xme:Z8BHaur-Afg-Q2tN-EMrnWk6kzNrbOyFEplz5uAuAxyGD862dHhkUPM9V10GAY0Ks
 s1CB3Du00qq99kzonXyKcw2Gdg4dl8jGnqG4bRJEoLdWfFP5c7L>
X-ME-Proxy-Cause: dmFkZTGOuhovtTr5hgl/HexamfYzq2u3YYLn/yjrS00gZsPDyGL6jqZPxV7Hu/ljU0yyOp
 FjBxHf+RVE7paMUCCg4T2LiEqjgrgFFRsHKCpFQObs9gK8Gk7yXrIbA2/2ZP8LMK7xihqL
 0Ndw/y+GrcFaSAevZ0XifzuZwphZ/xsk4jqeHPSuYfRvMHFFVCmLAQfe7CUD10LlqSk5Ee
 Z9nEAohvNMEGQ+B3mbJplIGnLHTSbOJXon8BjEp2RJ8olXvW4NNyN9TTWnRM0Xw6R7PZoT
 ZVhcLgAI7Vb6XSNROLA2UkjVmQnyk5DTcNKB7IO/udmjy5gpVI5Wka66AA/0q5VsgAKLJj
 euv0+jo1Akn5KZWfCmit1pi1WrV3GU3ieXG4niMMr7P9DEDzyKU+MZEC7DKJ+ZmKslOr4v
 mmqGldi+z6HXjkpuMqfqe259pF5tiMuq1T0jAIooJYIIhqsZcQ9O2n5E2PwMTw8KMKbXNm
 JIRDaQ7xUrgM/Ibru4P7JP0DCiz0jhRiIsX5f3HSDBQaDSbU1smmAzK240F3X9yYxcxqsk
 WZpZJCoAHjKryUfdED6lIzXCQioweSGK2XYkjj3ExCk/k9ReHQf4Q3f78gSKvEQJ+6GIx6
 zdFHSAdQRYfTA2Vm+ZseKOa7en2b7sYNevU0uvIitSHzzdxWWZwRNhI5FJXg
X-ME-Proxy: <xmx:Z8BHaqlvOys6nOAN31FchIUF-Q0_3Nmduwlc-uJzvRGLzyp97ilESA>
 <xmx:Z8BHaqS7L5URBTI-1mkXSgdy1s4nyHx82PqGi3TueOICVSpDbIiTBw>
 <xmx:Z8BHapGsBX9LGnzSZYLVFQVAZQPqwzjyVqrF4eIbjnussDrPyo_qKA>
 <xmx:Z8BHavGOlmiY7hoNWN0ucAggoOrFO1bcjgrA8mApSMVvvzq9liElEw>
 <xmx:Z8BHaj37eYDBP_0p-rCX27n_zB-F8GjTF5bUy3XWoAyk5XNFT5qfMrwm>
Feedback-ID: i03f14258:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 7F79115C008C; Fri,  3 Jul 2026 10:00:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AQ-x3yhqMGpV
Date: Fri, 03 Jul 2026 07:59:46 -0600
From: "Alex Williamson" <alex@shazbot.org>
To: "Satyanarayana K V P" <satyanarayana.k.v.p@intel.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>,
 "Michal Wajdeczko" <michal.wajdeczko@intel.com>,
 "Matthew Brost" <matthew.brost@intel.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Message-Id: <3500e357-1a3e-4325-9259-28c2023860a1@app.fastmail.com>
In-Reply-To: <20260703111357.3206071-3-satyanarayana.k.v.p@intel.com>
References: <20260703111357.3206071-3-satyanarayana.k.v.p@intel.com>
Subject: Re: [RFC 0/1] Forward AER errors to guest
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=103.168.172.153; envelope-from=alex@shazbot.org;
 helo=fhigh-a2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On Fri, Jul 3, 2026, at 5:13 AM, Satyanarayana K V P wrote:
> Today, vfio-pci unconditionally stops the VM when any error event is
> reported by device. This prevents guest-driven error handling and recovery
> for platforms that support PCIe AER.
>
> This series adds an optional vfio-pci extension parameter,
> "x-forward-aer=on", to forward AER errors to the guest instead of
> forcing an immediate VM stop. If the endpoint supports AER, the error is
> forwarded directly; otherwise, checks the upstream PCIe bridge and
> forwards the error there when supported.If neither device nor PCIe bridge
> supports AER, the VM is immediately stopped when the error is reported.

The error eventfd is signaled for err_detected in the host, this is the beginning of the host error handling and the point at which drivers should stop accessing the device until the resume callback.  Letting the VMM continue at this point does the opposite of that.  Thanks,

Alex

