Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F5EC5DF9B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 12:08:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyTSk-00025c-5v; Mon, 24 Aug 2026 08:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wyTSc-00024B-EG
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 08:07:31 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wyTSZ-0003tQ-6r
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 08:07:30 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-84874b52eabso4391628b3a.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 05:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787573245; x=1788178045; darn=nongnu.org;
 h=references:to:cc:in-reply-to:date:subject:mime-version:content-type
 :message-id:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sMCjqzSGHDt+RHNQnbw8IsTbs/06Ev3KfBlOsRd8qbo=;
 b=Syx7SEMWYDejFdcyzn60eIdXNLoKJZkYPtaxXUuXShQOTfxihZDzUrP9Yk2ZAbbn3U
 4uvFKqLNQ1VqAXY+Xd385ijRSUqqdEm+LIWkaGf62M9zhghhShrGRj4KNFZ/kB5MpfYw
 mgrVHtEQTIkLxDhN6kmc/IYceji5Nnwjd4TEjMN5dPhYc/Nw1JlKyevP2fGyn/IyYfev
 IYWyDiMOCnfHCQcXs8pDrXthWw06Nqk5rELEXrwsTYEYB4dICNxV6iSJZ+Yd2RStblVd
 1lFEGdUT6yXV3GgPH89AW/uGCmXIdlAK/kyJLVURQzzxmeq4A7pf61RRaBroOPsQJ2Oi
 WEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787573245; x=1788178045;
 h=references:to:cc:in-reply-to:date:subject:mime-version:content-type
 :message-id:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sMCjqzSGHDt+RHNQnbw8IsTbs/06Ev3KfBlOsRd8qbo=;
 b=OIcW0IV91Fp9HiT2NUdj45Y7YZ61ZwqM/lPmJKTID9FIuec+qSGhHMg4ZSydkxxbpW
 R9nJduHh3NoDWUpdHGWuZPw8Y4kLJE2mTaT62WbZmgoh4xXr+F/gcKr8AyCDBKuaZyUV
 6ohuWDi1ot0ODcnlhjQ9I68DUNSQmsi50TCy3byzj4X15MdKSgfiZ8THcVHadBbv/AxR
 1BSaefgGsb4PdqrcFoFphqftMLipprVKvRB4+ytEJoWKfIE91ulCHq24eF97F+q/8ewH
 8WPFc4XZbka6sAZNX1vlCrsYJ4RFbFGZIem8wTXrfq9pZOFqo9juurPNFOBkg0RbCkpn
 g3eA==
X-Gm-Message-State: AFuF++lvYPj5y/A9WioUQQyj5T8PG/Nt6p2hYIZKsfsVL7kRQgfK1uFs
 r2uiiJGHl5yXFXAxFGVsYVeLzcRYECCEYle/OYG3A56vIeqt2dfTVBSE
X-Gm-Gg: AR+sD11xlcHE66nTLV6ehC+5Ltah3Iyg0W5FilrNK1uGusqxWXXpuRxuOMViEuwthTt
 P0rnKwRnG10Gu163l6p2wi79yAWq8U27NWeuPyJ1Q5fxeDSk72GkxWLo3Zd6w0V5Hby+U6Goixg
 Nmhcn61GR3g8e9iMI6JamAzSJYKm7Oa3aT/Vrsw7JbmEbvRz/r8TO0L8qKWH4+nOCn1ifNFvveC
 9UL8wROGOgXZDzA864dXVQpvvXw4OHTh503oFSG+xQPQo+GH4ErdINSu//T031E+ZheYYnI6r8N
 12ds6pGK6gp1l5HUMMR6bxrbb+ywIOAtZAfBMM50LvtHZKRrnLU5CAOq2Vp47QFDft0Buqe3NUi
 9ZI3i3zve+2FQDiOpgqugmvOqT/gfGHPAVpPOmt84QEfZl42kxCycZ8NL7nIYAAKmsTIhsYklTb
 5cgEyo9yTNy/HF3+WCg8nC2nzxv0N1y/L7h1FrUWt/XqZ6FsNFlgiqh23y0U7AD22NGZ6N
X-Received: by 2002:a05:6a00:32c4:b0:848:4faa:480b with SMTP id
 d2e1a72fcca58-851fa01061bmr43609591b3a.12.1787573245215; 
 Mon, 24 Aug 2026 05:07:25 -0700 (PDT)
Received: from smtpclient.apple ([117.55.237.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8520ef07a12sm1920789b3a.16.2026.08.24.05.07.22
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 24 Aug 2026 05:07:24 -0700 (PDT)
From: Jack Wang <163wangjack@gmail.com>
Message-Id: <3B4705C2-B85A-4A27-96F9-C1AB5B304139@gmail.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_DF3AE4CD-F231-4070-AF05-B6488B5BDF6B"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v1 4/5] hw/arm: Add Axiado SoC AX3005
Date: Mon, 24 Aug 2026 20:07:09 +0800
In-Reply-To: <64edab19-b14b-4b9b-902b-a72f742faeae@axiado.com>
Cc: qemu-devel@nongnu.org,
 peter.maydell@linaro.org,
 qemu-arm@nongnu.org
To: kchiu@axiado.com
References: <64edab19-b14b-4b9b-902b-a72f742faeae@axiado.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=163wangjack@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--Apple-Mail=_DF3AE4CD-F231-4070-AF05-B6488B5BDF6B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


Hi Kuan_Jui

Sorry that my previous message was not clear enough.The build is not =
hang,but the machine initialization did not return of ax3005-evb. This =
is the reason why I said 'initialization did not complete=E2=80=99. If =
you want to reproduce the mistake,commands below will help you

../qemu/configure --target-list=3Daarch64-softmmu --enable-debug =
--enable-werror --disable-rust

ninja qemu-system-aarch64

After the build completes, start the emulator with:

printf '%s\n''{"execute":"qmp_capabilities"}' =
'{"execute":"query-status"}' =
'{"execute":"query-memory-size-summary=E2=80=9D}'{"execute":"quit=E2=80=9D=
}=E2=80=99 | build/qemu-system-aarch64 -M ax3005-evb -m 2G -display none =
-serial none -qmp stdio -S

QEMU printed the QMP greeting, but no response to the`qmp_capabilities` =
command was received. The process did not complete machine =
initialization and remained in the initialization path around =
`ax3005_init()`

And i noticed that you deliver new version. Cheer for this,maybe we =
could discuss more in new series.

Best regards : )
Jack Wang=20
> On Mon, 24 Aug 2026 09:50:09 +0800, Kuan-Jui Chiu <kchiu@axiado.com> =
wrote:
> Hi Jack
>=20
> Thanks for the test, could you share how you built and what the =
command=20
> was you used to test?
>=20
> I did not see this issue on my side, maybe I missed something
>=20
> B.R.
> Howard
>=20
> Jack Wang =E6=96=BC 2026/8/23 =E4=B8=8B=E5=8D=88 06:33 =E5=AF=AB=E9=81=93=
:
>=20
>=20

>> On Sun, 23 Aug 2026 18:33:01 +0800, Jack Wang <163wangjack@gmail.com =
<mailto:163wangjack@gmail.com>> wrote:
>> Hi Kuan-Jui
>>=20
>> I tested this series with ax3005-evb machine,the initialization did =
not complete.
>> The process showed it repeatedly executing in 'ax3005_init'
>>=20
>>> +static const TypeInfo ax3005_soc_types[] =3D {
>>> +    {
>>> +        .name           =3D TYPE_AX3005_SOC,
>>> +        .parent         =3D TYPE_SYS_BUS_DEVICE,
>>> +        .instance_size  =3D sizeof(Ax3005SoCState),
>>> +        .instance_init  =3D ax3005_init,
>>> +        .class_init     =3D ax3005_class_init,
>>> +    }
>>> +};
>>=20
>> You add instance_size here but forget to add class_size. Then qemu =
defaultly use SysBusDeviceClass=E2=80=99s class_size cause of father-son =
relationship.
>>=20
>>> +typedef struct Ax3005SoCClass {
>>> +    SysBusDeviceClass   parent;
>>> +
>>> +    uint32_t            num_cpus;
>>> +} Ax3005SoCClass;
>>=20
>> Here your struct apparently extend SysBusDeviceClass field. I think =
it is the way why previous repeating behavior.After add class_size =
locally and rebuild the the machine completed initialization and =
responded to QMP commands successfully.
>>=20
>> Best regards :)
>> Jack Wang

--Apple-Mail=_DF3AE4CD-F231-4070-AF05-B6488B5BDF6B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta charset=3D"UTF-8"><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br style=3D"caret-color: rgb(0, 0, 0); =
color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; display: inline !important; float: none;">Hi =
Kuan_Jui</span><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><span style=3D"caret-color: rgb(0, 0, 0); =
color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; display: inline =
!important; float: none;">Sorry that my previous message was not clear =
enough.The build is not hang,but the machine initialization did not =
return of ax3005-evb. This is the reason why I said 'initialization did =
not complete=E2=80=99. If you want to reproduce the mistake,commands =
below will help you</span><br style=3D"caret-color: rgb(0, 0, 0); color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><span style=3D"caret-color: rgb(0, 0, 0); =
color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; display: inline =
!important; float: none;">../qemu/configure =
--target-list=3Daarch64-softmmu --enable-debug --enable-werror =
--disable-rust</span><br style=3D"caret-color: rgb(0, 0, 0); color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><span style=3D"caret-color: rgb(0, 0, 0); =
color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; display: inline =
!important; float: none;">ninja qemu-system-aarch64</span><br =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><br style=3D"caret-color: rgb(0, 0, 0); =
color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; display: inline !important; float: none;">After =
the build completes, start the emulator with:</span><br =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><br style=3D"caret-color: rgb(0, 0, 0); =
color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; display: inline !important; float: none;">printf =
'%s\n''{"execute":"qmp_capabilities"}' '{"execute":"query-status"}' =
'{"execute":"query-memory-size-summary=E2=80=9D}'{"execute":"quit=E2=80=9D=
}=E2=80=99 | build/qemu-system-aarch64 -M ax3005-evb -m 2G -display none =
-serial none -qmp stdio -S</span><br style=3D"caret-color: rgb(0, 0, 0); =
color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><span style=3D"caret-color: rgb(0, 0, 0); =
color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; display: inline =
!important; float: none;">QEMU printed the QMP greeting, but no response =
to the`qmp_capabilities` command was received. The process did not =
complete machine initialization and remained in the initialization path =
around `ax3005_init()`</span><br style=3D"caret-color: rgb(0, 0, 0); =
color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><span style=3D"caret-color: rgb(0, 0, 0); =
color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; display: inline =
!important; float: none;">And i noticed that you deliver new version. =
Cheer for this,maybe we could discuss more in new series.</span><br =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><br style=3D"caret-color: rgb(0, 0, 0); =
color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; display: inline !important; float: none;">Best =
regards : )</span><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; display: inline !important; float: none;">Jack =
Wang<span class=3D"Apple-converted-space">&nbsp;</span></span><br =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><blockquote type=3D"cite" =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;">On Mon, =
24 Aug 2026 09:50:09 +0800, Kuan-Jui Chiu &lt;kchiu@axiado.com&gt; =
wrote:<br>Hi Jack<br><br>Thanks for the test, could you share how you =
built and what the command<span =
class=3D"Apple-converted-space">&nbsp;</span><br>was you used to =
test?<br><br>I did not see this issue on my side, maybe I missed =
something<br><br>B.R.<br>Howard<br><br>Jack Wang =E6=96=BC 2026/8/23 =
=E4=B8=8B=E5=8D=88 06:33 =E5=AF=AB=E9=81=93:<br><br><br></blockquote><br =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><blockquote type=3D"cite" =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;"><blockquote type=3D"cite">On Sun, 23 Aug 2026 18:33:01 +0800, =
Jack Wang &lt;<a =
href=3D"mailto:163wangjack@gmail.com">163wangjack@gmail.com</a>&gt; =
wrote:<br>Hi Kuan-Jui<br><br>I tested this series with ax3005-evb =
machine,the initialization did not complete.<br>The process showed it =
repeatedly executing in 'ax3005_init'<br><br><blockquote =
type=3D"cite">+static const TypeInfo ax3005_soc_types[] =3D {<br>+ =
&nbsp;&nbsp;&nbsp;{<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.name =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=3D =
TYPE_AX3005_SOC,<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.parent =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=3D =
TYPE_SYS_BUS_DEVICE,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.instance_size &nbsp;=3D =
sizeof(Ax3005SoCState),<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.instance_init &nbsp;=3D =
ax3005_init,<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.class_init =
&nbsp;&nbsp;&nbsp;&nbsp;=3D ax3005_class_init,<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+};<br></blockquote><br>You add instance_size =
here but forget to add class_size. Then qemu defaultly use =
SysBusDeviceClass=E2=80=99s class_size cause of father-son =
relationship.<br><br><blockquote type=3D"cite">+typedef struct =
Ax3005SoCClass {<br>+ &nbsp;&nbsp;&nbsp;SysBusDeviceClass =
&nbsp;&nbsp;parent;<br>+<br>+ &nbsp;&nbsp;&nbsp;uint32_t =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;num_cpus=
;<br>+} Ax3005SoCClass;<br></blockquote><br>Here your struct apparently =
extend SysBusDeviceClass field. I think it is the way why previous =
repeating behavior.After add class_size locally and rebuild the the =
machine completed initialization and responded to QMP commands =
successfully.<br><br>Best regards :)<br>Jack =
Wang</blockquote></blockquote></body></html>=

--Apple-Mail=_DF3AE4CD-F231-4070-AF05-B6488B5BDF6B--

