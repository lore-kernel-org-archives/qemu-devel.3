Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9908AC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 15:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rezna-0008Ni-3i; Tue, 27 Feb 2024 10:55:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <archith100@gmail.com>)
 id 1reziF-0008BP-Qb
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 10:49:48 -0500
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <archith100@gmail.com>)
 id 1reziE-0000E5-Bn
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 10:49:47 -0500
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-dc6dcd9124bso4592419276.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 07:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709048982; x=1709653782; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Uel+QpfU1N7a0AM+5o+CQentMuYq1pti17qA0OJEviI=;
 b=KVJzvsCNt/qBh3S+MNuxleVab5/e/s72KgNMlEwIRueydexhs3wKGKmbDSHdSrn+b0
 /XnBnZYs1P0Iyv3/AhgRPQOjGhAJhlSipUMMtc5ptEx/k4SIZeVznIuC+abYfhgD0K8k
 +YxVvO8X1KKbVeg22dUJU5gKGbgSgGgpaGwC4uKTGbbvOwG/70DqaBV+eLDQqWqTR7m3
 WSIt4giDd/8+benqfxbq9ZDF5IPGVI+EoA/7+0dGPcif3fdslocDwankKcMAJoy6Y9pr
 Vn6t1eo6LCrERDMzi6dTu8A3gKzOlADHFNQVmcHLaRPirMtBDiawJ5G52CTiShXQfBwc
 7V3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709048982; x=1709653782;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Uel+QpfU1N7a0AM+5o+CQentMuYq1pti17qA0OJEviI=;
 b=mvDmKJCF03Sm3Evw27aiTefcelDKMMu1Nc58J0oD3jCl3ImgqSenNYJClOGrcENjaJ
 lTGH+BZd4cXuzAqifsRVHClRpq5tF4g+MZh9DqaAjCw24N+cPMRh4uF/uLtZ4S+l5mMN
 t00PeSLsGt3CNvLfb4pMlpkt0481KMz8Q8/+NrUYFZVKeLQ7zCO/ElEkOTcOlZY11r6W
 D1fGMPXDzz+kWXxWiL9DOWWMal/N+MzL9D7UGgacMU2IeJP/Qx+vWMiv92HglztHO1wx
 HEFLCW8Am7k/etHVFlHbjsA0qtj467w0jSey88ivmnvZByfKa/05erRjm0qJ9jTn3Y5O
 HfbA==
X-Gm-Message-State: AOJu0Yw1kd/B3bH82cGljHdPF/H3rNEgXAV70+3dKgs/8emm2zMuDT04
 rWjgrfhVTQ/XWxNfG09u/TGSd5AZ3aXtT87Eh7KqQejxMp/mZSAyEmDAeXshmO7H3eCX2U+Mrlw
 uKH6dCyDgIEDcA+QaDHkXZtvGCQW6sjVRl0Ttig==
X-Google-Smtp-Source: AGHT+IEsh/mcnV+bHpps7nT6DFOrb+gLZLpKf6uSCDxj7Tfi8EMmSsqy+j8p0aQF7nAVO+QRhFVv3y9NpO562FPn5ZM=
X-Received: by 2002:a25:ab68:0:b0:dc2:470b:887e with SMTP id
 u95-20020a25ab68000000b00dc2470b887emr2485904ybi.21.1709048981841; Tue, 27
 Feb 2024 07:49:41 -0800 (PST)
MIME-Version: 1.0
From: Archith P <archith100@gmail.com>
Date: Tue, 27 Feb 2024 21:18:55 +0530
Message-ID: <CAEEPdR4v8G6CHDCCO-fLcWs-iBqoyKTGQzio_C0P-1ur0vgX0w@mail.gmail.com>
Subject: Does cortex-m55 in qemu have PMU?
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000776a8406125ef948"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=archith100@gmail.com; helo=mail-yb1-xb2a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 27 Feb 2024 10:55:15 -0500
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

--000000000000776a8406125ef948
Content-Type: text/plain; charset="UTF-8"

Hi,
I am trying to run code on mps3-an547 (QEMU Emulator) and want to check if
it has PMU (Performance Monitoring Unit) Enabled.

[I am getting PMU value from  ARM_PMU_Get_CCNTR() always zero]

I tried using the QMP command query-cpu-model-expansion
Is this a proper way to find out?
{
    "execute": "query-cpu-model-expansion",
    "arguments": {
        "type": "full",
        "model": {
            "name": "cortex-m55"
        }
    }
}
Gives:
{"return": {"model": {"name": "cortex-m55"}}}

Is there other way to find? Need Help.

Thanks and regards,
Archith

--000000000000776a8406125ef948
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div>I am trying to run code on=C2=A0mps3-an=
547 (QEMU Emulator) and want to check if it has PMU (Performance Monitoring=
 Unit) Enabled.=C2=A0</div><div><br></div><div>[I am getting PMU value from=
=C2=A0=C2=A0<span style=3D"background-color:rgb(245,245,245);font-family:Co=
nsolas,&quot;Courier New&quot;,monospace;font-size:14px;white-space:pre;col=
or:rgb(170,55,49);font-weight:bold">ARM_PMU_Get_CCNTR</span><span style=3D"=
background-color:rgb(245,245,245);font-family:Consolas,&quot;Courier New&qu=
ot;,monospace;font-size:14px;white-space:pre;color:rgb(119,119,119)">()</sp=
an>=C2=A0always zero]=C2=A0</div><div><br></div><div>I tried using the QMP =
command=C2=A0<span class=3D"gmail-n" style=3D"color:rgb(0,0,0);font-family:=
SFMono-Regular,Menlo,Monaco,Consolas,&quot;Liberation Mono&quot;,&quot;Cour=
ier New&quot;,Courier,monospace;font-size:12px;box-sizing:border-box">query=
</span><span class=3D"gmail-o" style=3D"font-family:SFMono-Regular,Menlo,Mo=
naco,Consolas,&quot;Liberation Mono&quot;,&quot;Courier New&quot;,Courier,m=
onospace;font-size:12px;box-sizing:border-box;color:rgb(102,102,102)">-</sp=
an><span class=3D"gmail-n" style=3D"color:rgb(0,0,0);font-family:SFMono-Reg=
ular,Menlo,Monaco,Consolas,&quot;Liberation Mono&quot;,&quot;Courier New&qu=
ot;,Courier,monospace;font-size:12px;box-sizing:border-box">cpu</span><span=
 class=3D"gmail-o" style=3D"font-family:SFMono-Regular,Menlo,Monaco,Consola=
s,&quot;Liberation Mono&quot;,&quot;Courier New&quot;,Courier,monospace;fon=
t-size:12px;box-sizing:border-box;color:rgb(102,102,102)">-</span><span cla=
ss=3D"gmail-n" style=3D"color:rgb(0,0,0);font-family:SFMono-Regular,Menlo,M=
onaco,Consolas,&quot;Liberation Mono&quot;,&quot;Courier New&quot;,Courier,=
monospace;font-size:12px;box-sizing:border-box">model</span><span class=3D"=
gmail-o" style=3D"font-family:SFMono-Regular,Menlo,Monaco,Consolas,&quot;Li=
beration Mono&quot;,&quot;Courier New&quot;,Courier,monospace;font-size:12p=
x;box-sizing:border-box;color:rgb(102,102,102)">-</span><span class=3D"gmai=
l-n" style=3D"color:rgb(0,0,0);font-family:SFMono-Regular,Menlo,Monaco,Cons=
olas,&quot;Liberation Mono&quot;,&quot;Courier New&quot;,Courier,monospace;=
font-size:12px;box-sizing:border-box">expansion</span></div><div>Is this a =
proper way to find out?</div>{<br>=C2=A0 =C2=A0 &quot;execute&quot;: &quot;=
query-cpu-model-expansion&quot;,<br>=C2=A0 =C2=A0 &quot;arguments&quot;: {<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;type&quot;: &quot;full&quot;,<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &quot;model&quot;: {<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;name&quot;: &quot;cortex-m55&quot;<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 }<br>=C2=A0 =C2=A0 }<br>}<br><div>Gives:</div><div>{&quot;re=
turn&quot;: {&quot;model&quot;: {&quot;name&quot;: &quot;cortex-m55&quot;}}=
}<br></div><div><br></div><div>Is there other way to find? Need Help.</div>=
<div><br></div><div>Thanks and regards,</div><div>Archith</div><div><br></d=
iv></div>

--000000000000776a8406125ef948--

