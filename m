Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D386EE01FD
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 02:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soDCe-0001OM-7E; Tue, 10 Sep 2024 22:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.jaloo@gmail.com>)
 id 1soDCb-0001Na-AT
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 22:35:29 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liu.jaloo@gmail.com>)
 id 1soDCZ-0003Xy-ME
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 22:35:29 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2f759b87f83so44753821fa.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 19:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726022125; x=1726626925; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ntnPznz/DbDEcWBWTXLxqHdu346KVpx5TKu0GOEbxD0=;
 b=i0MipDFYZdM7JSxHeDgDq/DH6sJNqyx99x7l6rQg8sqh0lnmjn6uCSl9KuHLRD5TnK
 fAi/1zv3jC0mzb59CB9M+eAYeStNEnVIjrf5XTf6PC0SoETryKPR4YNIAUTSzAlffp0j
 qltQbOir3G+Z3zlR8h5h52RntqP7kLNcplMXEAdSkEYQIIts/aAS1/mCfcOm9e5Q21+o
 wKAc65yoWdGXMujVbcHxkR6AnMmXpRMbJWOemTxr9nsrshOksBpg3zPEN+PVpy59aZ9v
 AzWUbqrrVATDu6yPv3NfZHWJMayOMpy7U3Y9iLH658UKGgibW495ndLLmVq5igP12BYC
 /+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726022125; x=1726626925;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ntnPznz/DbDEcWBWTXLxqHdu346KVpx5TKu0GOEbxD0=;
 b=Ywg2l45ejEYMF6cJDVx/e184N84Ii3HuN7bOpHaMVKNHF74ArAJ5FSyMOfntsDS2VR
 hP/scX1+Ejo4xkMAnywUSagUJbM8KzDOlkQzfIUK4jq0lq4IhFzENKFVIstvFCP5yDqj
 8/OR1gCC1O2uI5olj3jyi+wr1YooTHpSArQ28xRhsmvckgMvgM+4JA80h0jUgGQv3xqn
 9LYrtSo2E4yxep9dAcnRdeqbByaiCZSDlqkcnxDNJQy6s0REzJQCu0eOEiSDJd5mwovx
 3xnCZ5RN6fNasUzT5J2P3lQmGw47Ix6hvve2+90FpCyWNE6aoyCwW8S0qjDHbDw/rScI
 ohsg==
X-Gm-Message-State: AOJu0Yw5pxthb8xJfeaYdhx2neHdgfb3UlfXs8QZ24eB4SqBvLdvdxu9
 c8IGEXSQQuEt/7PGdo0VuzTguoWKQ2dj0xOlKNA4KJKHRZSjZPJVwD9LcxvEESNRIB3LvLCOJXD
 JfvxVvx3kBmlEUMOUI2d3hwRn8t66VloelncWOic=
X-Google-Smtp-Source: AGHT+IGysVB4N/rjsvSc1+Jp9fadRolwAKVvSqnmLoV/4pI5XAoFp55lOJPqk04OxSCZUGLt7uQcu272GklMwcUu0+U=
X-Received: by 2002:a05:651c:1989:b0:2ef:2bb4:45d with SMTP id
 38308e7fff4ca-2f751eaf2c4mr78855391fa.9.1726022124105; Tue, 10 Sep 2024
 19:35:24 -0700 (PDT)
MIME-Version: 1.0
From: Liu Jaloo <liu.jaloo@gmail.com>
Date: Wed, 11 Sep 2024 10:35:12 +0800
Message-ID: <CAOYM0N2Kf6-0k_NUsT2u5iQ_LKZFLtLpL6PpCCFD-+kvFLE3Vw@mail.gmail.com>
Subject: about "-netdev id=id" User Documentation
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000094f9870621ced7fa"
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=liu.jaloo@gmail.com; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--00000000000094f9870621ced7fa
Content-Type: text/plain; charset="UTF-8"

on qemu-manpage (https://www.qemu.org/docs/master/system/qemu-manpage.html)
-netdev user,id=id[,option][,option][,...]
...
id=id

Assign symbolic name for use in monitor commands.


on qemu-wikipage (https://wiki.qemu.org/Documentation/Networking)

-netdev TYPE,id=NAME,...

The id option gives the name by which the virtual network device and the
network backend are associated with each other. If you want multiple
virtual network devices inside the guest they each need their own network
backend. The name is used to distinguish backends from each other and must
be used even when only one backend is specified.


Maybe the content on wiki page is more suitable, please have a check,
Thanks. Regards

--00000000000094f9870621ced7fa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>on qemu-manpage (<a href=3D"https://www.qemu.org/docs=
/master/system/qemu-manpage.html">https://www.qemu.org/docs/master/system/q=
emu-manpage.html</a>)</div><div><dt><code class=3D"gmail-docutils gmail-lit=
eral gmail-notranslate"><span class=3D"gmail-pre">-netdev</span> <span clas=
s=3D"gmail-pre">user,id=3Did[,option][,option][,...]</span></code></dt></di=
v><div><dt>...<br><code class=3D"gmail-docutils gmail-literal gmail-notrans=
late"><span class=3D"gmail-pre"></span></code></dt><dt><code class=3D"gmail=
-docutils gmail-literal gmail-notranslate"><span class=3D"gmail-pre">id=3Di=
d</span></code></dt><dd><p>Assign symbolic name for use in monitor commands=
.</p></dd></div><div><br></div><div><br></div><div>on qemu-wikipage (<a hre=
f=3D"https://wiki.qemu.org/Documentation/Networking">https://wiki.qemu.org/=
Documentation/Networking</a>)</div><div><br></div><div><pre>-netdev TYPE,id=
=3DNAME,...
</pre>
<p>The <tt>id</tt> option gives the name by which the virtual network=20
device and the network backend are associated with each other.  If you=20
want multiple virtual network devices inside the guest they each need=20
their own network backend.  The name is used to distinguish backends=20
from each other and must be used even when only one backend is=20
specified. <br></p><p><br></p><p>Maybe the content on wiki page is more sui=
table, please have a check, Thanks. Regards<br></p></div></div>

--00000000000094f9870621ced7fa--

