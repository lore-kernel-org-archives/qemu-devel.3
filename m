Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5573EC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 16:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raeeD-0004qm-63; Thu, 15 Feb 2024 11:31:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faiqueali.109@gmail.com>)
 id 1radL8-00006c-SW
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 10:07:56 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faiqueali.109@gmail.com>)
 id 1radL2-0003EV-4x
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 10:07:54 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-55f50cf2021so1350859a12.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 07:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708009663; x=1708614463; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Fvw7t7txE8tGO9yD8Vbm+sVZTcggAkNf/7WmJGToWwk=;
 b=QidZVG8W1FU6hTDtWqVQvo/AQe3bil+dex1Ngi7/+dT+vC57dnK8NtuvKmhlMjgXYV
 d9J+N/aoWJq6CWK7kJmYzvTanleQRGD+aLJ7SZososLRrBfniZLzPSKtIH5E/AD9iq6C
 odNhhV/Wwn9hoHMqgjihuPdRvbQ5kWrcEEWE+dWj0XfkH65apBBRK8MrnWAvIUPMNhAN
 0JsLAQxMSlk9bIT6yHuQohttenbFF49V1EfxgHuVgn5qFGtkxRsGAIXxUAb3McjRv19b
 qUzdJivN9ehu/F2zFDv/ceaCUc4zXOcoNpdZ+P2JlXL4bt9hGnyirn+YWhj+YmTSnHXo
 p15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708009663; x=1708614463;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fvw7t7txE8tGO9yD8Vbm+sVZTcggAkNf/7WmJGToWwk=;
 b=dXhYq2Do/YH3Ix5My8nK4tfLI2KS9kOqIESvIckyB9FPU9cRJJrRDu1/i+rja95eFj
 MV7FBBJyganfwx5Ym1VmXXXtuz1NoiqDMI6Te99MEbzARnCCqYyaWeCh9bc7dkvpJ3Fq
 6g7JqzLFpWbL0xIr1FLp8nPG2rjLOWP3rhDl/YEeHXVjYdjFY+Hd9A7HJ52lDLaMpRJd
 y+pUmJvY9OsgMgCbY0SbT06zt3nh+UZJyxvg1qEaWfNk6/6ImfpbLkfsQEuzMM77UuR3
 +VkajDj0ACpE+pVrbm96fa/9gd14auvgKgf+sCYoqTlQdTvIhRd/Hplqlnpf2beMLuIx
 MrMA==
X-Gm-Message-State: AOJu0Yw4PEPpbylMqTr7Yc2awojhl6r/5Het/ffbJ2m4wlZVN54FguOr
 gdcpFvlzNpFAMzK/02sfaMOMcrTISy/uH0TbAPzN2PDzht6l0c8f1lMfJVVMopKxmRBcuQQxJ5d
 o5g8kRkkg81KZSMp+WIEcAkkJx4IDYEbBPLM=
X-Google-Smtp-Source: AGHT+IFfensS8DLpT77rrjcBPMCMxexPYNr4rRrbDagGToWtH/+NuRDY74n7Z50jEfwJGdfGUoogUyxarmH2CxHRlkc=
X-Received: by 2002:aa7:c48c:0:b0:561:caa5:c12e with SMTP id
 m12-20020aa7c48c000000b00561caa5c12emr1528534edq.34.1708009663504; Thu, 15
 Feb 2024 07:07:43 -0800 (PST)
MIME-Version: 1.0
From: Faiq Ali Sayed <faiqueali.109@gmail.com>
Date: Thu, 15 Feb 2024 16:07:32 +0100
Message-ID: <CAOpGCnKC7YE8DV8eCi4zA5LtqdiL5So+ceNV63udDXmRJxeFFw@mail.gmail.com>
Subject: Qemu network connectivity issue
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000004424ba06116cfd63"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=faiqueali.109@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 HTML_FONT_LOW_CONTRAST=0.001, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 15 Feb 2024 11:31:40 -0500
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

--0000000000004424ba06116cfd63
Content-Type: text/plain; charset="UTF-8"

Hi my name is Faiq Ali Sayed
Currently, I am trading to create a Qemu VM with the command below and
getting an error and the terminal hangs after that

*Command:*

qemu-system-aarch64 -M xlnx-zcu102 -m 16G -serial mon:stdio -display none
-device loader,file=QNX-IFS,addr=0x00100000,cpu-num=0
-net nic,model=cadence_gem -net nic,model=cadence_gem -net
nic,model=cadence_gem -net nic,model=cadence_gem,netdev=xzynq0 -netdev
user,id=xzynq0,tftp=/tftpboot
-nographic -global xlnx,zynqmp-boot.cpu-num=0 -global
'xlnx,zynqmp-boot.use-pmufw=true'


*Error:*
*qemu-system-aarch64: warning: hub 0 is not connected to host network*

any help in this regard is highly appreciated.

Thanks :)

-- 
Kind Regard-
Faiq Ali Sayed

--0000000000004424ba06116cfd63
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi my name is Faiq Ali Sayed=C2=A0<div>Currently, I am tra=
ding=C2=A0to create a Qemu VM with the command below and getting an error a=
nd the terminal=C2=A0hangs after that=C2=A0</div><div><br></div><div><u>Com=
mand:</u></div><div><br></div><div>qemu-system-aarch64 -M xlnx-zcu102 -m 16=
G -serial mon:stdio -display none <br>-device loader,file=3DQNX-IFS,addr=3D=
0x00100000,cpu-num=3D0 <br>-net nic,model=3Dcadence_gem -net nic,model=3Dca=
dence_gem -net nic,model=3Dcadence_gem -net nic,model=3Dcadence_gem,netdev=
=3Dxzynq0 -netdev user,id=3Dxzynq0,tftp=3D/tftpboot =C2=A0<br>-nographic -g=
lobal xlnx,zynqmp-boot.cpu-num=3D0 -global &#39;xlnx,zynqmp-boot.use-pmufw=
=3Dtrue&#39;<br></div><div><br></div><div><br></div><div><u>Error:</u></div=
><div><b><i><font color=3D"#f3f3f3" style=3D"background-color:rgb(0,0,0)">q=
emu-system-aarch64: warning: hub 0 is not connected to host network</font><=
/i></b><br></div><div><br></div><div>any help in this regard is highly appr=
eciated.</div><div><br></div><div>Thanks :)<br clear=3D"all"><div><br></div=
><span class=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" clas=
s=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><=
div dir=3D"ltr">
<div><span style=3D"color:rgb(34,34,34)">Kind Regard-</span><br style=3D"co=
lor:rgb(34,34,34)"><div dir=3D"ltr" style=3D"color:rgb(34,34,34)"><div dir=
=3D"ltr"><div dir=3D"ltr"><font color=3D"#073763">Faiq Ali Sayed</font></di=
v></div></div></div>
<div><font style=3D"background-color:#ffffff" size=3D"1"><br></font></div><=
br></div></div></div></div></div>

--0000000000004424ba06116cfd63--

