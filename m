Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D215C5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 17:55:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcqns-0008Rz-L4; Wed, 21 Feb 2024 12:54:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rnn59437@gmail.com>)
 id 1rcp1U-0006xv-1F
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 11:00:40 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rnn59437@gmail.com>)
 id 1rcp1S-0006Oo-5I
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 11:00:39 -0500
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3c03d6e5e56so6602851b6e.1
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 08:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708531235; x=1709136035; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=lJE4Kjwg3TrdibjjfLq0rNT469REyE7RACwAw6Ap77M=;
 b=cFNG4Z/oLReUh1WNtB13kMHKH0rrU/M8PCaI/4GZ9j1YIMFE7YehG3wm1jxEwuL2wQ
 z4Zvwoc3kbD/ORk8filQNjsGN3ioKju9ROx/JKSxzpOy4gMm6fey4nSePQmWC/gmMwbg
 TSF93fEmP/YtfZD15ZHN/G5jhNxX0pYn4mk3/g0nyyoj3IUknEeWg7JodsWKLDo5TTeo
 3ylWTLeY9F6StyH9FgPsDU7fsP4FlFWzV1vzzmH8J6Iu5Qc1G3mfCCcTr8i7dlTdHURG
 cau5umxxuMTJgmYlR5acV2XCzRVFy5jY+3o8d42as/cwoxVoBrpI8SpY3pxMTKayB7Dc
 FsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708531235; x=1709136035;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lJE4Kjwg3TrdibjjfLq0rNT469REyE7RACwAw6Ap77M=;
 b=NAJNfh6FTbJZRfRvpZjieC3oxwF+Dadc4TRTJSNH0pegyMq7A/cdOEUdbLUGWqq70w
 TWpcxgXRq7Sa6vtnbVNjMv1YAWNoeICXQvu+BSRJ6l+UHpBfNJBNzwN/LCn7vBIuIpKA
 TFcS8n2EvEgILlaB9Wc73oX27JeMMVc/jt3FJYiFs++tS/m68aA8ELzRHxZFxLZojZXb
 w+yqckONDYRE0DmG5gQbIVUYvFA0KAMLsEgY9uN8qtXXwdJV3HC5O3hs+EZeMEJ69p9d
 KEM4KrrKGewzgWF5mszeuw4guz36JGmr8TKGJtiJYLRmofe+JWanKtKXQb2ijYeNFj81
 /XYA==
X-Gm-Message-State: AOJu0YyuI4Y41g72sP0YvXdGJVkt/paYaj0zBFe4A060hhs7H+BzqAPs
 k2c5IEg6OXfSRc7RP3NssQddcNVUbrW7E2s+msNmC/xen6rS0N6GL4xuptSx5ITTlQ+SomLYn3d
 mjqKhCKZaxLxTZK9bjEGP5pylCSZAewTiYSVXcg==
X-Google-Smtp-Source: AGHT+IHU3Ai6Y/ZNWkzFbfD3gtrSnS6D7bk2Yiz4BoKrQNIckMRtsr9P5rwXAcvHvzxxgDR6YkAaL4O/MOqQlWQ9dmA=
X-Received: by 2002:a05:6870:2214:b0:21e:5008:cf62 with SMTP id
 i20-20020a056870221400b0021e5008cf62mr22450343oaf.21.1708531234948; Wed, 21
 Feb 2024 08:00:34 -0800 (PST)
MIME-Version: 1.0
From: RR NN <rnn59437@gmail.com>
Date: Wed, 21 Feb 2024 19:30:23 +0330
Message-ID: <CAK4oD7At_cyrfZKCR_yS=f1UJmmQekyaW-=_1S8Qpyw5Nx3o3Q@mail.gmail.com>
Subject: Support Android hypervisors
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000058ca2c0611e66df9"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=rnn59437@gmail.com; helo=mail-oi1-x22b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 21 Feb 2024 12:54:40 -0500
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

--00000000000058ca2c0611e66df9
Content-Type: text/plain; charset="UTF-8"

 Android Virtualization Framework (AVF) supports "KVM(pKVM)" also
Qualcomm's "Gunyah" and MediaTek's "GenieZone" as the hypervisor. Please
Add these hypervisors to QEMU.

--00000000000058ca2c0611e66df9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">=C2=A0Android Virtualization Framework (AVF) supports &qu=
ot;KVM(pKVM)&quot; also Qualcomm&#39;s &quot;Gunyah&quot; and MediaTek&#39;=
s &quot;GenieZone&quot; as the hypervisor. Please Add these hypervisors to =
QEMU.</div>

--00000000000058ca2c0611e66df9--

