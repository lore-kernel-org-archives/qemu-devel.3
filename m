Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7E8C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 13:22:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1nQE-0007F7-LG; Tue, 30 Apr 2024 09:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1s1nQC-0007EB-59; Tue, 30 Apr 2024 09:21:25 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1s1nQA-0002m7-1m; Tue, 30 Apr 2024 09:21:23 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6f0aeee172dso3954208b3a.1; 
 Tue, 30 Apr 2024 06:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714483279; x=1715088079; darn=nongnu.org;
 h=mime-version:subject:references:in-reply-to:message-id:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=fUNWGztb+nRVe2vPVRbdcEBvVAwxoQS12x58wCuwJ7k=;
 b=ICr2Hve7Q1RLUzhD0OxA1jiqnk9QswLryKaQaRcOmVZpglX10LTMatkjICJtzzPVVp
 7kivf4CettjXRCv5YW77ynXqLAzr7IpTb2qINiDIo2UQo4VqWW3iVZ4TnxEM6+NRXc6z
 kbisVdCvzg7WHuWiqhjMNV5dUqb8EanzzXpRPJHD43Szirfy8T9V1RoBrRA1iWBkbxoV
 t+1cWGJerH7QsYeagx3yv6zwGyS8Z/Rjh4CCPUnUj/oxM0S8WcFnTO3iDjvkbh01eDal
 6nNrceuaAFNUc8yFcMzBGBNWVxjf4nIENrTecgJRyPqjRmuGXfyqnyg6mFqlpEK8ha5S
 yrMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714483279; x=1715088079;
 h=mime-version:subject:references:in-reply-to:message-id:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fUNWGztb+nRVe2vPVRbdcEBvVAwxoQS12x58wCuwJ7k=;
 b=bkPDq28WZC8cnvmOHGAzMaRtPwBrblMCysDTbfUDN1ZvdQyzYpPSD+ZSudT8l6t+aI
 +mhSYcwwOfojO39e7FpOxTTlX0pUZSSgnBfDqb4PpykrHzkqNFo2orVyjc88uWjzb6bW
 W5cQmtsvY+PM2IXFOXUjRQlnsHGZe/SxlFN+n/0679BicxG7PEWHJDG+yNDXI7IkzAO3
 gkUwyZaGJgSzd1p44R9VMAcLnq0xlihFBUInPtl/473gLi1vs4wBNaZPGH6ukxxsd9xL
 3z7rBrcvzf6IoprSABNmsFWxoh78kU181IqrwjY6ekCerEw/C+gLx5rmrAuT4xzaTf14
 SAdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4aP4A1OeDalfwTENSI8X4jA0W9rUfI4ldHqZ5x639+XBS32pTyLBVRp7GNxNaoZTCAUq4mq985yqpyR9BwxOeoAq9pjc=
X-Gm-Message-State: AOJu0Yy8gaPwtxR3DjKaNiuFPtOZ+gWKuV81jDEm/tN4f9v/DOatNm90
 ErrHnqaKdf0O4v7JMUWlTCQ1ClEOG+0tRCBjKUabNWPBeziJr+qrWW41eKJA
X-Google-Smtp-Source: AGHT+IHRZyiNGGCwayXC76hyYXKY1tkZ9njMjV2f81YlnSq7xNmfawye48v1vSCLp71S1/quug5Qsg==
X-Received: by 2002:a05:6a20:9786:b0:1a7:1c9:5f86 with SMTP id
 hx6-20020a056a20978600b001a701c95f86mr3526505pzc.16.1714483278472; 
 Tue, 30 Apr 2024 06:21:18 -0700 (PDT)
Received: from amjad-pc ([192.228.203.229]) by smtp.gmail.com with ESMTPSA id
 i28-20020a63585c000000b005d5445349edsm20566909pgm.19.2024.04.30.06.21.16
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 30 Apr 2024 06:21:18 -0700 (PDT)
Date: Tue, 30 Apr 2024 21:21:15 +0800
From: Amjad Alsharafi <amjadsharafi10@gmail.com>
To: "=?utf-8?Q?qemu-devel=40nongnu.org?=" <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?utf-8?Q?open_list=3Avvfat?= <qemu-block@nongnu.org>
Message-ID: <6035ACB3-ABFB-4576-A309-860BB76882D0@getmailspring.com>
In-Reply-To: <ZhpVofMHYUewg2qq@amjad-pc>
References: <ZhpVofMHYUewg2qq@amjad-pc>
Subject: Re: [PATCH 0/3] vvfat: Fix bugs in writing and reading files -- PING
X-Mailer: Mailspring
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="6630f04b_5af23dbe_bdf5"
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=amjadsharafi10@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--6630f04b_5af23dbe_bdf5
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Ping again

On Apr 13 2024, at 5:51 pm, Amjad Alsharafi <amjadsharafi10@gmail.com> wrote:
> Ping to the vvfat maintainers.
>


--6630f04b_5af23dbe_bdf5
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Ping again</div><br><div class=3D=22gmail=5Fquote=5Fattribution=22>O=
n Apr 13 2024, at 5:51 pm, Amjad Alsharafi &lt;amjadsharafi10=40gmail.com=
&gt; wrote:</div><blockquote><div><div>Ping to the vvfat maintainers.</di=
v></div></blockquote>
--6630f04b_5af23dbe_bdf5--


