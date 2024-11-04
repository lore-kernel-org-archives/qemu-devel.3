Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D5FD132C8
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 13:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7xNK-0003SD-Ci; Mon, 04 Nov 2024 08:44:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1t7xN9-0003IZ-Hn
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 08:44:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1t7xN7-0002w3-40
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 08:43:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730727835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IvGXeJ1DlZ4AMNl71vI+BrbU5+nUwfjDjsuGXGq8HdU=;
 b=FGahK+1APWkshlIXl//mq+BNyE5NKcD7pZ8kVYSGbZx3W6k8b/OiiaCHN+Gn/FW1jYBEVc
 VPG+IqA36TKwM7XV40wNtOghHYBNRvfDoHz+BHpvQ6N2VEkUw0bgwqPQ1HTjJXj5o+w+jl
 3YaO8CneaHJR2HpN3GQO38RAveAXeUA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-itFDI-7qNriKk9WtUq5DYw-1; Mon, 04 Nov 2024 08:43:53 -0500
X-MC-Unique: itFDI-7qNriKk9WtUq5DYw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6cbf039dccfso79883496d6.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 05:43:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730727833; x=1731332633;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IvGXeJ1DlZ4AMNl71vI+BrbU5+nUwfjDjsuGXGq8HdU=;
 b=WRnvWjL9wN3pIsVmeiyMGXWGzFVvS2QBXN6ndXSoYoBSP1UPfKYuBAhonngOD6lfPy
 hPus3s0LZe4ESByRXxypRJiGUoIAhyQZRXeEf50qkEJjy8XNp3QKKLw3WQSD1PVGGVmE
 vwypInxFwXbcYolgxRDKMwnTpEP2W8+MyAY9PRLCpif+PkRXvZNFVcg1M6J6eBL3x5+/
 QDrwR/f5rJLzYElWMti6Oy1/9QC+lvEmg9NSjg8HoNElLOatocLXwILiQ+1jx8NXuw21
 75JFrP112HVLMtI7cR9KmfMz33V7w537+XkoARk+okig4g2nV5hQWjwqlYL88FqjQN0+
 /5oQ==
X-Gm-Message-State: AOJu0YwPMXGc72rTAUfd+n48zKAyCvHPlV6VNeKFRrLgJybodsZqod6b
 g1U+qES2idTcri8Gb6gB/44lgQKu0t5ZyFxxzH+92LcNrO2XtuGlb0ll/bjTcPgyncBmOaQLVjv
 5lZZddf6x2sRidq/lfbrg0L+qE8yWoq9zcN10Rkk+b/VVr/u7LrUAgC73I6ogsVR2fIbuOa8sBj
 JX5nmwdC28Xpw+KtBh20+g/2O+ERM=
X-Received: by 2002:a05:6214:4406:b0:6d3:77b8:cb3 with SMTP id
 6a1803df08f44-6d377b80d00mr47169206d6.12.1730727833323; 
 Mon, 04 Nov 2024 05:43:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFjqYskCx2Nlv+Yutb6Ifqf+fVytGKFIFlqPOTv2htj7Y07yOBImq1mWDVJ7VG+1LaVCZKyipI72RSly4IDI0=
X-Received: by 2002:a05:6214:4406:b0:6d3:77b8:cb3 with SMTP id
 6a1803df08f44-6d377b80d00mr47169036d6.12.1730727833061; Mon, 04 Nov 2024
 05:43:53 -0800 (PST)
MIME-Version: 1.0
References: <20241031040426.772604-1-pierrick.bouvier@linaro.org>
 <20241031040426.772604-7-pierrick.bouvier@linaro.org>
 <CAPMcbCp8343bXBV36jwJBtdQxNjd8RjtbRO048jMpt-Q+Swh+g@mail.gmail.com>
In-Reply-To: <CAPMcbCp8343bXBV36jwJBtdQxNjd8RjtbRO048jMpt-Q+Swh+g@mail.gmail.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Mon, 4 Nov 2024 15:43:42 +0200
Message-ID: <CAPMcbCo74T9j0V9QE1Yr2EEdAYDOen8Kehzw1HLvUoy8MquxEw@mail.gmail.com>
Subject: Re: [PATCH 06/12] qga: fix missing static and prototypes windows
 warnings
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
Content-Type: multipart/alternative; boundary="000000000000b15c8506261679f2"
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

--000000000000b15c8506261679f2
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
>> Reported by clang++, but not by g++.
>>
>> ../qga/vss-win32/provider.cpp:48:6: error: no previous prototype for
>> function 'LockModule' [-Werror,-Wmissing-prototypes]
>>    48 | void LockModule(BOOL lock)
>>       |      ^
>> ../qga/vss-win32/provider.cpp:48:1: note: declare 'static' if the
>> function is not intended to be used outside of this translation unit
>>    48 | void LockModule(BOOL lock)
>>       | ^
>>       | static
>> ../qga/vss-win32/provider.cpp:531:13: error: no previous prototype for
>> function 'DllMain' [-Werror,-Wmissing-prototypes]
>>   531 | BOOL WINAPI DllMain(HINSTANCE hinstDll, DWORD dwReason, LPVOID
>> lpReserved)
>>       |             ^
>> ../qga/vss-win32/provider.cpp:531:1: note: declare 'static' if the
>> function is not intended to be used outside of this translation unit
>>   531 | BOOL WINAPI DllMain(HINSTANCE hinstDll, DWORD dwReason, LPVOID
>> lpReserved)
>>       | ^
>>       | static
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>  qga/vss-win32/install.cpp   | 6 +++++-
>>  qga/vss-win32/provider.cpp  | 5 ++++-
>>  qga/vss-win32/requester.cpp | 8 ++++----
>>  3 files changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
>> index 84944133f79..5cea5bcf747 100644
>> --- a/qga/vss-win32/install.cpp
>> +++ b/qga/vss-win32/install.cpp
>> @@ -39,7 +39,7 @@ const GUID CLSID_WbemLocator =3D { 0x4590f811, 0x1d3a,
>> 0x11d0,
>>  const GUID IID_IWbemLocator =3D { 0xdc12a687, 0x737f, 0x11cf,
>>      {0x88, 0x4d, 0x00, 0xaa, 0x00, 0x4b, 0x2e, 0x24} };
>>
>> -void errmsg(DWORD err, const char *text)
>> +static void errmsg(DWORD err, const char *text)
>>  {
>>      /*
>>       * `text' contains function call statement when errmsg is called vi=
a
>> chk().
>> @@ -242,6 +242,7 @@ out:
>>  }
>>
>>  /* Unregister this module from COM+ Applications Catalog */
>> +STDAPI COMUnregister(void);
>>  STDAPI COMUnregister(void)
>>  {
>>      qga_debug_begin;
>> @@ -256,6 +257,7 @@ out:
>>  }
>>
>>  /* Register this module to COM+ Applications Catalog */
>> +STDAPI COMRegister(void);
>>  STDAPI COMRegister(void)
>>  {
>>      qga_debug_begin;
>> @@ -380,11 +382,13 @@ out:
>>      return hr;
>>  }
>>
>> +STDAPI_(void) CALLBACK DLLCOMRegister(HWND, HINSTANCE, LPSTR, int);
>>  STDAPI_(void) CALLBACK DLLCOMRegister(HWND, HINSTANCE, LPSTR, int)
>>  {
>>      COMRegister();
>>  }
>>
>> +STDAPI_(void) CALLBACK DLLCOMUnregister(HWND, HINSTANCE, LPSTR, int);
>>  STDAPI_(void) CALLBACK DLLCOMUnregister(HWND, HINSTANCE, LPSTR, int)
>>  {
>>      COMUnregister();
>> diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/provider.cpp
>> index cc72e5ef1b9..a102a23fbf1 100644
>> --- a/qga/vss-win32/provider.cpp
>> +++ b/qga/vss-win32/provider.cpp
>> @@ -45,7 +45,7 @@ const IID IID_IVssEnumObject =3D { 0xAE1C7110, 0x2F60,
>> 0x11d3,
>>      {0x8A, 0x39, 0x00, 0xC0, 0x4F, 0x72, 0xD8, 0xE3} };
>>
>>
>> -void LockModule(BOOL lock)
>> +static void LockModule(BOOL lock)
>>  {
>>      if (lock) {
>>          InterlockedIncrement(&g_nComObjsInUse);
>> @@ -527,6 +527,9 @@ STDAPI DllCanUnloadNow()
>>      return g_nComObjsInUse =3D=3D 0 ? S_OK : S_FALSE;
>>  }
>>
>> +EXTERN_C
>> +BOOL WINAPI DllMain(HINSTANCE hinstDll, DWORD dwReason, LPVOID
>> lpReserved);
>> +
>>  EXTERN_C
>>  BOOL WINAPI DllMain(HINSTANCE hinstDll, DWORD dwReason, LPVOID
>> lpReserved)
>>  {
>> diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
>> index 9884c65e707..4401d55e3a4 100644
>> --- a/qga/vss-win32/requester.cpp
>> +++ b/qga/vss-win32/requester.cpp
>> @@ -254,8 +254,8 @@ out:
>>      qga_debug_end;
>>  }
>>
>> -DWORD get_reg_dword_value(HKEY baseKey, LPCSTR subKey, LPCSTR valueName=
,
>> -                          DWORD defaultData)
>> +static DWORD get_reg_dword_value(HKEY baseKey, LPCSTR subKey, LPCSTR
>> valueName,
>> +                                 DWORD defaultData)
>>  {
>>      qga_debug_begin;
>>
>> @@ -272,12 +272,12 @@ DWORD get_reg_dword_value(HKEY baseKey, LPCSTR
>> subKey, LPCSTR valueName,
>>      return dwordData;
>>  }
>>
>> -bool is_valid_vss_backup_type(VSS_BACKUP_TYPE vssBT)
>> +static bool is_valid_vss_backup_type(VSS_BACKUP_TYPE vssBT)
>>  {
>>      return (vssBT > VSS_BT_UNDEFINED && vssBT < VSS_BT_OTHER);
>>  }
>>
>> -VSS_BACKUP_TYPE get_vss_backup_type(
>> +static VSS_BACKUP_TYPE get_vss_backup_type(
>>      VSS_BACKUP_TYPE defaultVssBT =3D DEFAULT_VSS_BACKUP_TYPE)
>>  {
>>      qga_debug_begin;
>> --
>> 2.39.5
>>
>>

--000000000000b15c8506261679f2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Pierrick,</div><div><br></div><div>I got this patc=
h in my PULL with QGA patches.<br></div><div><br></div><div><div><div dir=
=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div =
dir=3D"ltr"><div>Best Regards,</div><div>Konstantin Kostiuk.</div></div></d=
iv></div><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cl=
ass=3D"gmail_attr">On Thu, Oct 31, 2024 at 3:32=E2=80=AFPM Konstantin Kosti=
uk &lt;<a href=3D"mailto:kkostiuk@redhat.com">kkostiuk@redhat.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=
=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkostiuk@red=
hat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 31, 2024=
 at 6:05=E2=80=AFAM Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bouvier=
@linaro.org" target=3D"_blank">pierrick.bouvier@linaro.org</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">Reported by clang=
++, but not by g++.<br>
<br>
../qga/vss-win32/provider.cpp:48:6: error: no previous prototype for functi=
on &#39;LockModule&#39; [-Werror,-Wmissing-prototypes]<br>
=C2=A0 =C2=A048 | void LockModule(BOOL lock)<br>
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 ^<br>
../qga/vss-win32/provider.cpp:48:1: note: declare &#39;static&#39; if the f=
unction is not intended to be used outside of this translation unit<br>
=C2=A0 =C2=A048 | void LockModule(BOOL lock)<br>
=C2=A0 =C2=A0 =C2=A0 | ^<br>
=C2=A0 =C2=A0 =C2=A0 | static<br>
../qga/vss-win32/provider.cpp:531:13: error: no previous prototype for func=
tion &#39;DllMain&#39; [-Werror,-Wmissing-prototypes]<br>
=C2=A0 531 | BOOL WINAPI DllMain(HINSTANCE hinstDll, DWORD dwReason, LPVOID=
 lpReserved)<br>
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^<br>
../qga/vss-win32/provider.cpp:531:1: note: declare &#39;static&#39; if the =
function is not intended to be used outside of this translation unit<br>
=C2=A0 531 | BOOL WINAPI DllMain(HINSTANCE hinstDll, DWORD dwReason, LPVOID=
 lpReserved)<br>
=C2=A0 =C2=A0 =C2=A0 | ^<br>
=C2=A0 =C2=A0 =C2=A0 | static<br>
<br>
Signed-off-by: Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@lina=
ro.org" target=3D"_blank">pierrick.bouvier@linaro.org</a>&gt;<br>
---<br>
=C2=A0qga/vss-win32/install.cpp=C2=A0 =C2=A0| 6 +++++-<br>
=C2=A0qga/vss-win32/provider.cpp=C2=A0 | 5 ++++-<br>
=C2=A0qga/vss-win32/requester.cpp | 8 ++++----<br>
=C2=A03 files changed, 13 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp<br>
index 84944133f79..5cea5bcf747 100644<br>
--- a/qga/vss-win32/install.cpp<br>
+++ b/qga/vss-win32/install.cpp<br>
@@ -39,7 +39,7 @@ const GUID CLSID_WbemLocator =3D { 0x4590f811, 0x1d3a, 0x=
11d0,<br>
=C2=A0const GUID IID_IWbemLocator =3D { 0xdc12a687, 0x737f, 0x11cf,<br>
=C2=A0 =C2=A0 =C2=A0{0x88, 0x4d, 0x00, 0xaa, 0x00, 0x4b, 0x2e, 0x24} };<br>
<br>
-void errmsg(DWORD err, const char *text)<br>
+static void errmsg(DWORD err, const char *text)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * `text&#39; contains function call statement when err=
msg is called via chk().<br>
@@ -242,6 +242,7 @@ out:<br>
=C2=A0}<br>
<br>
=C2=A0/* Unregister this module from COM+ Applications Catalog */<br>
+STDAPI COMUnregister(void);<br>
=C2=A0STDAPI COMUnregister(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0qga_debug_begin;<br>
@@ -256,6 +257,7 @@ out:<br>
=C2=A0}<br>
<br>
=C2=A0/* Register this module to COM+ Applications Catalog */<br>
+STDAPI COMRegister(void);<br>
=C2=A0STDAPI COMRegister(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0qga_debug_begin;<br>
@@ -380,11 +382,13 @@ out:<br>
=C2=A0 =C2=A0 =C2=A0return hr;<br>
=C2=A0}<br>
<br>
+STDAPI_(void) CALLBACK DLLCOMRegister(HWND, HINSTANCE, LPSTR, int);<br>
=C2=A0STDAPI_(void) CALLBACK DLLCOMRegister(HWND, HINSTANCE, LPSTR, int)<br=
>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0COMRegister();<br>
=C2=A0}<br>
<br>
+STDAPI_(void) CALLBACK DLLCOMUnregister(HWND, HINSTANCE, LPSTR, int);<br>
=C2=A0STDAPI_(void) CALLBACK DLLCOMUnregister(HWND, HINSTANCE, LPSTR, int)<=
br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0COMUnregister();<br>
diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/provider.cpp<br>
index cc72e5ef1b9..a102a23fbf1 100644<br>
--- a/qga/vss-win32/provider.cpp<br>
+++ b/qga/vss-win32/provider.cpp<br>
@@ -45,7 +45,7 @@ const IID IID_IVssEnumObject =3D { 0xAE1C7110, 0x2F60, 0x=
11d3,<br>
=C2=A0 =C2=A0 =C2=A0{0x8A, 0x39, 0x00, 0xC0, 0x4F, 0x72, 0xD8, 0xE3} };<br>
<br>
<br>
-void LockModule(BOOL lock)<br>
+static void LockModule(BOOL lock)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0if (lock) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0InterlockedIncrement(&amp;g_nComObjsInUse=
);<br>
@@ -527,6 +527,9 @@ STDAPI DllCanUnloadNow()<br>
=C2=A0 =C2=A0 =C2=A0return g_nComObjsInUse =3D=3D 0 ? S_OK : S_FALSE;<br>
=C2=A0}<br>
<br>
+EXTERN_C<br>
+BOOL WINAPI DllMain(HINSTANCE hinstDll, DWORD dwReason, LPVOID lpReserved)=
;<br>
+<br>
=C2=A0EXTERN_C<br>
=C2=A0BOOL WINAPI DllMain(HINSTANCE hinstDll, DWORD dwReason, LPVOID lpRese=
rved)<br>
=C2=A0{<br>
diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp<br>
index 9884c65e707..4401d55e3a4 100644<br>
--- a/qga/vss-win32/requester.cpp<br>
+++ b/qga/vss-win32/requester.cpp<br>
@@ -254,8 +254,8 @@ out:<br>
=C2=A0 =C2=A0 =C2=A0qga_debug_end;<br>
=C2=A0}<br>
<br>
-DWORD get_reg_dword_value(HKEY baseKey, LPCSTR subKey, LPCSTR valueName,<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 DWORD defaultData)<br>
+static DWORD get_reg_dword_value(HKEY baseKey, LPCSTR subKey, LPCSTR value=
Name,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DWORD defaultData)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0qga_debug_begin;<br>
<br>
@@ -272,12 +272,12 @@ DWORD get_reg_dword_value(HKEY baseKey, LPCSTR subKey=
, LPCSTR valueName,<br>
=C2=A0 =C2=A0 =C2=A0return dwordData;<br>
=C2=A0}<br>
<br>
-bool is_valid_vss_backup_type(VSS_BACKUP_TYPE vssBT)<br>
+static bool is_valid_vss_backup_type(VSS_BACKUP_TYPE vssBT)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0return (vssBT &gt; VSS_BT_UNDEFINED &amp;&amp; vssBT &l=
t; VSS_BT_OTHER);<br>
=C2=A0}<br>
<br>
-VSS_BACKUP_TYPE get_vss_backup_type(<br>
+static VSS_BACKUP_TYPE get_vss_backup_type(<br>
=C2=A0 =C2=A0 =C2=A0VSS_BACKUP_TYPE defaultVssBT =3D DEFAULT_VSS_BACKUP_TYP=
E)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0qga_debug_begin;<br>
-- <br>
2.39.5<br>
<br>
</blockquote></div>
</blockquote></div>

--000000000000b15c8506261679f2--


