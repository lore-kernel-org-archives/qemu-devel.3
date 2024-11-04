Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F08FD132C8
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 13:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7xNb-0003cN-J7; Mon, 04 Nov 2024 08:44:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1t7xNM-0003VJ-Bd
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 08:44:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1t7xNI-0002wn-VX
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 08:44:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730727848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=awvF9aqoOr5F9UURnoccPFCcWwIEFgxGl5lrK4P4yfA=;
 b=BEdQUSCDY0nUmVYIAATs80gGJLlxf+TPpJ1H93Na9Cw43XW4XaX+fNFiLMA0SgF3CxdH7O
 sX0EekPZACvSz4SD5Adsgj636vkCfYE0HWHCK/NlYZNmPOjgL75yxPGTqzzJ4Kgvv9zBEj
 qmVr+Reb7It87Iz+n/4a492RVjHresg=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-Cd9dfq5cOd6z1Z7YsXIubA-1; Mon, 04 Nov 2024 08:44:06 -0500
X-MC-Unique: Cd9dfq5cOd6z1Z7YsXIubA-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7092f2d50ceso3151658a34.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 05:44:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730727846; x=1731332646;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=awvF9aqoOr5F9UURnoccPFCcWwIEFgxGl5lrK4P4yfA=;
 b=XboJlpYpJrz2jj9S0eSI354ovjvZA0xIrBtfk1ZI6xynHCItzKQrVXzPhD8msqPXWB
 EXuYcRf+SJ9MvsU884zTdoaGH8qNYyXFTRuY8AAIbrRSH3DHnJFeGOeTtC2yJn/6ZfIA
 32YEZCYtl1KhPdrFBPRZE0/u1wdMd+HWWH/rv47M4ciGcNEJEPeHjKromsmOO9E5K/UY
 cCIw+pGp0fB09yGTTuy7D6FrBYMV6GluzcZm++NrRQL4fLYXV2fFQk6NXPfc63hdj1rC
 nqp3zmHOpdJ1BkZlVenOEMWTNjsNuf5pkrWqvPyFl6KhxDxibUiWZUFyT5XhaLajnXiG
 /hbA==
X-Gm-Message-State: AOJu0YyQPin77wM4X3xFUtXOT2rVvSijjGRoZkw+pQPTTtFtMgib3aLS
 R1MGzS1r/Ma6MZdATiRn3o8S6wn29jaa5KydyPmsTn16MyFo1rgVd2H76XhqCa6oDIwlqMYJ9UO
 dTfkS2WwDgtL5aoQMthxOCbmvN2d77ifR8ALmNY0G1YFKmCjGE2rSctyKRgJ+pSMnVmecgnQ6Ta
 Y8YA9cQxaaTv8XE9BJnl2tPQ7N81M=
X-Received: by 2002:a05:6359:1006:b0:1c3:813d:47c2 with SMTP id
 e5c5f4694b2df-1c5f9a15db7mr416908055d.20.1730727846067; 
 Mon, 04 Nov 2024 05:44:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUcRt4QDXvq86qEaVGFChqIZufJZ8v8cTVbFYNjIl6mtC8XXXxDWGqPDBdFLaM/aEZZvy5DU2zYh7HS3qzrSg=
X-Received: by 2002:a05:6359:1006:b0:1c3:813d:47c2 with SMTP id
 e5c5f4694b2df-1c5f9a15db7mr416905755d.20.1730727845824; Mon, 04 Nov 2024
 05:44:05 -0800 (PST)
MIME-Version: 1.0
References: <20241031040426.772604-1-pierrick.bouvier@linaro.org>
 <20241031040426.772604-6-pierrick.bouvier@linaro.org>
 <CAPMcbCqhhHp0swCu=eQhmBtq1osssnAbShMNCRaGKL0V+1Na9w@mail.gmail.com>
In-Reply-To: <CAPMcbCqhhHp0swCu=eQhmBtq1osssnAbShMNCRaGKL0V+1Na9w@mail.gmail.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Mon, 4 Nov 2024 15:43:54 +0200
Message-ID: <CAPMcbCr1Z_tDg002Sfb=Az8ZTCgDwhnttRPEkQ8YYWXT-jBSrg@mail.gmail.com>
Subject: Re: [PATCH 05/12] qga: fix -Wsometimes-uninitialized windows warning
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Alexandre Iooss <erdnaxe@crans.org>, 
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000741fa20626167ac8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

--000000000000741fa20626167ac8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pierrick,

I got this patch in my PULL with QGA patches.

Best Regards,
Konstantin Kostiuk.

On Thu, Oct 31, 2024 at 3:32=E2=80=AFPM Konstantin Kostiuk <kkostiuk@redhat=
.com>
wrote:

> Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
>
> On Thu, Oct 31, 2024 at 6:05=E2=80=AFAM Pierrick Bouvier <
> pierrick.bouvier@linaro.org> wrote:
>
>> Reported by clang, but not gcc.
>>
>> [5123/5678] Compiling C object
>> qga/qemu-ga.exe.p/commands-windows-ssh.c.obj
>> FAILED: qga/qemu-ga.exe.p/commands-windows-ssh.c.obj
>> "cc" "-Iqga/qemu-ga.exe.p" "-Iqga" "-I../qga" "-I." "-Iqapi" "-Itrace"
>> "-Iui" "-Iui/shader" "-IC:/msys64/clangarm64/include/glib-2.0"
>> "-IC:/msys64/clangarm64/lib/glib-2.0/include" "-fdiagnostics-color=3Daut=
o"
>> "-Wall" "-Winvalid-pch" "-Werror" "-std=3Dgnu11" "-O2" "-g"
>> "-fstack-protector-strong" "-Wempty-body" "-Wendif-labels"
>> "-Wexpansion-to-defined" "-Wformat-security" "-Wformat-y2k"
>> "-Wignored-qualifiers" "-Winit-self" "-Wmissing-format-attribute"
>> "-Wmissing-prototypes" "-Wnested-externs" "-Wold-style-definition"
>> "-Wredundant-decls" "-Wstrict-prototypes" "-Wtype-limits" "-Wundef" "-Wv=
la"
>> "-Wwrite-strings" "-Wno-gnu-variable-sized-type-not-at-end"
>> "-Wno-initializer-overrides" "-Wno-missing-include-dirs" "-Wno-psabi"
>> "-Wno-shift-negative-value" "-Wno-string-plus-int"
>> "-Wno-tautological-type-limit-compare" "-Wno-typedef-redefinition"
>> "-Wthread-safety" "-iquote" "." "-iquote" "C:/w/qemu" "-iquote"
>> "C:/w/qemu/include" "-iquote" "C:/w/qemu/host/include/aarch64" "-iquote"
>> "C:/w/qemu/host/include/generic" "-iquote" "C:/w/qemu/tcg/aarch64"
>> "-D_GNU_SOURCE" "-D_FILE_OFFSET_BITS=3D64" "-D_LARGEFILE_SOURCE"
>> "-fno-strict-aliasing" "-fno-common" "-fwrapv" "-fno-pie"
>> "-ftrivial-auto-var-init=3Dzero" "-fzero-call-used-regs=3Dused-gpr" -MD =
-MQ
>> qga/qemu-ga.exe.p/commands-windows-ssh.c.obj -MF
>> "qga/qemu-ga.exe.p/commands-windows-ssh.c.obj.d" -o
>> qga/qemu-ga.exe.p/commands-windows-ssh.c.obj "-c"
>> ../qga/commands-windows-ssh.c
>> ../qga/commands-windows-ssh.c:383:9: error: variable 'userPSID' is used
>> uninitialized whenever 'if' condition is true
>> [-Werror,-Wsometimes-uninitialized]
>>   383 |     if (!create_acl(userInfo, &pACL, errp)) {
>>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ../qga/commands-windows-ssh.c:415:15: note: uninitialized use occurs her=
e
>>   415 |     LocalFree(userPSID);
>>       |               ^~~~~~~~
>> ../qga/commands-windows-ssh.c:383:5: note: remove the 'if' if its
>> condition is always false
>>   383 |     if (!create_acl(userInfo, &pACL, errp)) {
>>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>   384 |         goto error;
>>       |         ~~~~~~~~~~~
>>   385 |     }
>>       |     ~
>> ../qga/commands-windows-ssh.c:380:18: note: initialize the variable
>> 'userPSID' to silence this warning
>>   380 |     PSID userPSID;
>>       |                  ^
>>       |                   =3D NULL
>> 1 error generated.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>  qga/commands-windows-ssh.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/qga/commands-windows-ssh.c b/qga/commands-windows-ssh.c
>> index 6a642e3ba81..df45c17b757 100644
>> --- a/qga/commands-windows-ssh.c
>> +++ b/qga/commands-windows-ssh.c
>> @@ -377,7 +377,7 @@ error:
>>  static bool set_file_permissions(PWindowsUserInfo userInfo, Error **err=
p)
>>  {
>>      PACL pACL =3D NULL;
>> -    PSID userPSID;
>> +    PSID userPSID =3D NULL;
>>
>>      /* Creates the access control structure */
>>      if (!create_acl(userInfo, &pACL, errp)) {
>> --
>> 2.39.5
>>
>>

--000000000000741fa20626167ac8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Pierrick,</div><div><br></div><div>I got this patc=
h in my PULL with QGA patches.<br></div><div><br></div><div><div><div dir=
=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Best Regards,</div=
><div>Konstantin Kostiuk.</div></div></div></div></div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 31, 2024=
 at 3:32=E2=80=AFPM Konstantin Kostiuk &lt;<a href=3D"mailto:kkostiuk@redha=
t.com">kkostiuk@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex"><div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk =
&lt;<a href=3D"mailto:kkostiuk@redhat.com" target=3D"_blank">kkostiuk@redha=
t.com</a>&gt;</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">On Thu, Oct 31, 2024 at 6:05=E2=80=AFAM Pierrick Bouvier &lt;<=
a href=3D"mailto:pierrick.bouvier@linaro.org" target=3D"_blank">pierrick.bo=
uvier@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">Reported by clang, but not gcc.<br>
<br>
[5123/5678] Compiling C object qga/qemu-ga.exe.p/commands-windows-ssh.c.obj=
<br>
FAILED: qga/qemu-ga.exe.p/commands-windows-ssh.c.obj<br>
&quot;cc&quot; &quot;-Iqga/qemu-ga.exe.p&quot; &quot;-Iqga&quot; &quot;-I..=
/qga&quot; &quot;-I.&quot; &quot;-Iqapi&quot; &quot;-Itrace&quot; &quot;-Iu=
i&quot; &quot;-Iui/shader&quot; &quot;-IC:/msys64/clangarm64/include/glib-2=
.0&quot; &quot;-IC:/msys64/clangarm64/lib/glib-2.0/include&quot; &quot;-fdi=
agnostics-color=3Dauto&quot; &quot;-Wall&quot; &quot;-Winvalid-pch&quot; &q=
uot;-Werror&quot; &quot;-std=3Dgnu11&quot; &quot;-O2&quot; &quot;-g&quot; &=
quot;-fstack-protector-strong&quot; &quot;-Wempty-body&quot; &quot;-Wendif-=
labels&quot; &quot;-Wexpansion-to-defined&quot; &quot;-Wformat-security&quo=
t; &quot;-Wformat-y2k&quot; &quot;-Wignored-qualifiers&quot; &quot;-Winit-s=
elf&quot; &quot;-Wmissing-format-attribute&quot; &quot;-Wmissing-prototypes=
&quot; &quot;-Wnested-externs&quot; &quot;-Wold-style-definition&quot; &quo=
t;-Wredundant-decls&quot; &quot;-Wstrict-prototypes&quot; &quot;-Wtype-limi=
ts&quot; &quot;-Wundef&quot; &quot;-Wvla&quot; &quot;-Wwrite-strings&quot; =
&quot;-Wno-gnu-variable-sized-type-not-at-end&quot; &quot;-Wno-initializer-=
overrides&quot; &quot;-Wno-missing-include-dirs&quot; &quot;-Wno-psabi&quot=
; &quot;-Wno-shift-negative-value&quot; &quot;-Wno-string-plus-int&quot; &q=
uot;-Wno-tautological-type-limit-compare&quot; &quot;-Wno-typedef-redefinit=
ion&quot; &quot;-Wthread-safety&quot; &quot;-iquote&quot; &quot;.&quot; &qu=
ot;-iquote&quot; &quot;C:/w/qemu&quot; &quot;-iquote&quot; &quot;C:/w/qemu/=
include&quot; &quot;-iquote&quot; &quot;C:/w/qemu/host/include/aarch64&quot=
; &quot;-iquote&quot; &quot;C:/w/qemu/host/include/generic&quot; &quot;-iqu=
ote&quot; &quot;C:/w/qemu/tcg/aarch64&quot; &quot;-D_GNU_SOURCE&quot; &quot=
;-D_FILE_OFFSET_BITS=3D64&quot; &quot;-D_LARGEFILE_SOURCE&quot; &quot;-fno-=
strict-aliasing&quot; &quot;-fno-common&quot; &quot;-fwrapv&quot; &quot;-fn=
o-pie&quot; &quot;-ftrivial-auto-var-init=3Dzero&quot; &quot;-fzero-call-us=
ed-regs=3Dused-gpr&quot; -MD -MQ qga/qemu-ga.exe.p/commands-windows-ssh.c.o=
bj -MF &quot;qga/qemu-ga.exe.p/commands-windows-ssh.c.obj.d&quot; -o qga/qe=
mu-ga.exe.p/commands-windows-ssh.c.obj &quot;-c&quot; ../qga/commands-windo=
ws-ssh.c<br>
../qga/commands-windows-ssh.c:383:9: error: variable &#39;userPSID&#39; is =
used uninitialized whenever &#39;if&#39; condition is true [-Werror,-Wsomet=
imes-uninitialized]<br>
=C2=A0 383 |=C2=A0 =C2=A0 =C2=A0if (!create_acl(userInfo, &amp;pACL, errp))=
 {<br>
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~<br>
../qga/commands-windows-ssh.c:415:15: note: uninitialized use occurs here<b=
r>
=C2=A0 415 |=C2=A0 =C2=A0 =C2=A0LocalFree(userPSID);<br>
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0^~~~~~~~<br>
../qga/commands-windows-ssh.c:383:5: note: remove the &#39;if&#39; if its c=
ondition is always false<br>
=C2=A0 383 |=C2=A0 =C2=A0 =C2=A0if (!create_acl(userInfo, &amp;pACL, errp))=
 {<br>
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~<br>
=C2=A0 384 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error;<br>
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0~~~~~~~~~~~<br>
=C2=A0 385 |=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0~<br>
../qga/commands-windows-ssh.c:380:18: note: initialize the variable &#39;us=
erPSID&#39; to silence this warning<br>
=C2=A0 380 |=C2=A0 =C2=A0 =C2=A0PSID userPSID;<br>
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ^<br>
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D NULL<br>
1 error generated.<br>
<br>
Signed-off-by: Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@lina=
ro.org" target=3D"_blank">pierrick.bouvier@linaro.org</a>&gt;<br>
---<br>
=C2=A0qga/commands-windows-ssh.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/qga/commands-windows-ssh.c b/qga/commands-windows-ssh.c<br>
index 6a642e3ba81..df45c17b757 100644<br>
--- a/qga/commands-windows-ssh.c<br>
+++ b/qga/commands-windows-ssh.c<br>
@@ -377,7 +377,7 @@ error:<br>
=C2=A0static bool set_file_permissions(PWindowsUserInfo userInfo, Error **e=
rrp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0PACL pACL =3D NULL;<br>
-=C2=A0 =C2=A0 PSID userPSID;<br>
+=C2=A0 =C2=A0 PSID userPSID =3D NULL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Creates the access control structure */<br>
=C2=A0 =C2=A0 =C2=A0if (!create_acl(userInfo, &amp;pACL, errp)) {<br>
-- <br>
2.39.5<br>
<br>
</blockquote></div>
</blockquote></div>

--000000000000741fa20626167ac8--


