Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F420C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 17:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzdU3-000512-0d; Thu, 27 Aug 2026 13:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1wzdU1-00050r-VH
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 13:01:45 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1wzdTz-000263-CQ
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 13:01:45 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-38d489b6b71so237432a91.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 10:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787850101; x=1788454901; darn=nongnu.org;
 h=mime-version:content-transfer-encoding:content-type:msip_labels
 :content-language:accept-language:in-reply-to:references:message-id
 :date:thread-index:thread-topic:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8+kxKG6VLsRBulZwbmISRI2Az+9/qH1/uQGV8zfJEp0=;
 b=iPinxIu1mZ3/KzmnYo3+rbvxmULxLWnCQLVMEBAdRCmwDJbdkf9bRimTBwMhqxj1tH
 JYOf1iqucuROwldkUv6v425QOqXNJfQ3adK+F0Cz5tNwq3QEP48phY75Gxg4RVmuuLrv
 OMxa4buIzXd5//pobAxNXZ5flC51HVd4IrWpPmK+1kRf3HiJlQc90gwH573D5iMvWC1o
 AA35PKpEBIRMCbc5mAZJxjqjcXvMHFgdyK1IKnDBDBV11ZcY3dbOJoKtpJdCQB6j3YNy
 vHjdJOty2aX3nQ1oYFYjfxPFBuDsgRxxT5ofizMyCLHCS8qYNhyAXTd9DL/RiSySFmHx
 dHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787850101; x=1788454901;
 h=mime-version:content-transfer-encoding:content-type:msip_labels
 :content-language:accept-language:in-reply-to:references:message-id
 :date:thread-index:thread-topic:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8+kxKG6VLsRBulZwbmISRI2Az+9/qH1/uQGV8zfJEp0=;
 b=rlUOY6huhnIIPK+U9uRbTL/27tAodIbzUpHA4r9x25PPhyZB9hAElTvcIPQCkb91dm
 tV29KU6cjAoK1uoBKLD1lijby+Botq7kyma/jk+qyOADwjjeHZ784JTEmhV0Xmyza/M2
 87qKTNcTuNphqvnLExNQsDJjdOV+iRx0560mKHXiCVzfypfFgHpO3jVe5aZgDerBE5c7
 aJzn5Adi87G8rMl1b39bEW7fdNx0sxFYRA9ddEuBgNcACAbgDuqnfQdEWm2Ou7G9iBf6
 pbN5eqAqHnNCCUbzLbWuHzRwQwuLR8rj2mztOkCSlCUq9cWiwxr2CfX52WjFdGFIRHU+
 sUUw==
X-Gm-Message-State: AFuF++krrGaAKyZh6WdDDHRbBYrYEluHVIgZjnIZ+WNKUtyoH2hxnzKj
 NjQSYYTa6/vpW+9LjfEDYNq4SzZu8KO1f2H614iIa1n92JPZlXa0474cvegTCQ==
X-Gm-Gg: AR+sD13ggwQtuXrpdtA95VIUg7ywc+hRG7HI3f42fYpdFC1B2exIQNmy+7cK+akhNBd
 Xr6TiePFnGddWpwjqSnLSSSb89KwKpIezeN8XHExgxxXVgDUerFCVUN29oloiLoF5RHI2R7IoOE
 U6mM1aHn4oHxZZdMWXYBedhp/sBPcNBJc9oDcaBWTdG4Xrwe8oNwBbA0QGex1MfyejkcpSik4HT
 AZzMKhqu1HSCHlhsGwE2KEc9gBbAIokncjettAT7O1mZkvWF6BYvj4JIJvLRUGkV446izAn0F02
 C0LBK9urpXnJFqZoVUROVPNcvfOBsBKGSrDreEyi1iietwEAjTrsICFqT/g1tvyKGw6PaXfplzA
 DKWXqr07/Dqt8PUJRXeczv6lNczaX3bp8ruHN0RxX5vHPIR+W50YpVYbsb2q65ncivOa6TZ9dZb
 SAY0NbhDT7hQGy+ZglowYIvvtGe7O9oLWzfRzoPCQQ4UMqCaPGegiylEbsG0YHBRICu76INrw+u
 15Gp9HGKv6qoy52HDeEQy5W2z3blLN9FJpqa/2fei9jijLS4vpAkUdp
X-Received: by 2002:a17:90b:5249:b0:396:40e6:f631 with SMTP id
 98e67ed59e1d1-396d0e306e0mr1295355a91.3.1787850101345; 
 Thu, 27 Aug 2026 10:01:41 -0700 (PDT)
Received: from DM6PR02MB4940.namprd02.prod.outlook.com
 ([2603:1036:301:207d::5]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396d2316e21sm57776a91.2.2026.08.27.10.01.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 10:01:40 -0700 (PDT)
From: Simon Xu <simonxhy0404@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>
Subject: Re: [PATCH v3 0/9] arm: add Cortex-M85, SSE-310, and mps3-an555
Thread-Topic: [PATCH v3 0/9] arm: add Cortex-M85, SSE-310, and mps3-an555
Thread-Index: ATRuLS44HD97kWM+YfPstzJYr9R1UkFjT2FDz4UUPgY=
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Thu, 27 Aug 2026 17:01:39 +0000
Message-ID: <DM6PR02MB4940D2540AED137ED68D2944FEAD2@DM6PR02MB4940.namprd02.prod.outlook.com>
References: <20260818002629.172827-1-simonxhy0404@gmail.com>
 <CAFEAcA-bqCPVV2a_g-nav=GYj20DCOTU8pts4BRct8_qvqwbzA@mail.gmail.com>
In-Reply-To: <CAFEAcA-bqCPVV2a_g-nav=GYj20DCOTU8pts4BRct8_qvqwbzA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels: 
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=simonxhy0404@gmail.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Sounds good. Thank you Peter for your help with my first=0A=
experience with open source software! I appreciate your=0A=
feedback and hope to stay around in the future.=0A=
=0A=
Best regards,=0A=
Simon Xu=

