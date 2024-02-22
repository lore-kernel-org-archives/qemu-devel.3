Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E12C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 08:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd48B-0008OA-1G; Thu, 22 Feb 2024 03:08:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rd484-0008Lx-Lu
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 03:08:29 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rd482-0006yv-63
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 03:08:28 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40fb3b5893eso46209535e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 00:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708589304; x=1709194104; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9LB/EnyVoZguy8E3bbYZG8fnu1qZJKZp5+pxuj8HzCA=;
 b=QCTM6pVLeBdipCUm2nSJ2zsg3Eznoy/nxbT/F9ycWa8ap81kRtoIJN3GxGgz0NU5nE
 zUi9yEvhNAwRikZv0S6FQade/vo400WlJy4rl5+A2sd9Slwb/XR5gGySZAn1KrRO5/hq
 hhaPojnN8aHGdoxEWzLfsmYFe/yR3Pn1hkXO9m9FkxBHfaryAYCN/wIsPjagI4xiFpum
 MMy0nkpzbGw0F7ZfSsFzc2uyrSS2QsP/R/1zw1BH4ClYY5GnG6NhuuE+r1DQHKQ9d9HZ
 5KCBd4Z8nD3gPoDnQ+JF5CHPw1RjHc/R8AcwadgU7dw4U+PgBpP2glzYav1dIyIr4fJh
 2yVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708589304; x=1709194104;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9LB/EnyVoZguy8E3bbYZG8fnu1qZJKZp5+pxuj8HzCA=;
 b=jQ5oFRDkNmqhtsG+leU/nRITLA9fRknWbf5VkZzgf96YIV3gpVMIvtE6Kcmyi0T0DA
 WQ6mDDrx6/DAK9C1q4CbnMBCxIo/nkvuN2O+QP2YHMmmIiGCqTu4TtD13d2xMN7iK115
 KzlzCCEwnt0a7W1IX/BRPQg6/a+DfCdVJ/SbalmL67csBHJmQ1V6T4FvdMrJtlq19+2/
 4YtbbNzjhnsg/ay7nskCPMLmFj1LQrXPE19tQOn2VEUfMQqE+dgqmEUHgqbeRpLy7EnP
 yNdgMtQoZhodaviRII/ATmM7OKbxwH0h58uZcaA847BAbZFg7rrnXjbSKw3pkdt1tOsx
 +pmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaAM7d+Ybpo1WABLe9AtkUB+ixxBY6G2iVCZyOC5jdEGJpmplmE2RmKht8Bgsi61r7DemIvDX9N38565hTmjqJHJ4vCPc=
X-Gm-Message-State: AOJu0YziXW76iX3A70UdO1FU02EJFLAPnvLKEJyZPHsOOMDmUifwJLnU
 Y8WW1UL+R4IqAig0s7Vj85BdtqS4lRzlzTScvyHDNN48ySKLhJPEH+7NftSA76I=
X-Google-Smtp-Source: AGHT+IGuJGUH23sZH4IfCR8H3quNvzlQsqgdbjvQo12GQbByLVKTszaxKUQWuHFbTYSuOdcqFgP4gQ==
X-Received: by 2002:a05:600c:4fc4:b0:410:68e1:d9ca with SMTP id
 o4-20020a05600c4fc400b0041068e1d9camr15989813wmq.2.1708589304473; 
 Thu, 22 Feb 2024 00:08:24 -0800 (PST)
Received: from [192.168.184.175] (41.red-95-127-32.staticip.rima-tde.net.
 [95.127.32.41]) by smtp.gmail.com with ESMTPSA id
 p18-20020a05600c359200b0041256523bf8sm18380530wmq.31.2024.02.22.00.08.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Feb 2024 00:08:23 -0800 (PST)
Message-ID: <25146207-d188-4489-9331-b694d81fe19b@linaro.org>
Date: Thu, 22 Feb 2024 09:08:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] qga-win: Add support of Windows Server 2025 in
 get-osinfo command
Content-Language: en-US
To: Dehan Meng <demeng@redhat.com>, qemu-devel@nongnu.org
Cc: kkostiuk@redhat.com, michael.roth@amd.com
References: <20240222025437.58996-1-demeng@redhat.com>
 <20240222025437.58996-2-demeng@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240222025437.58996-2-demeng@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Dehan,

On 22/2/24 03:54, Dehan Meng wrote:
> Add support of Windows Server 2025 in get-osinfo command
> 
> Signed-off-by: Dehan Meng <demeng@redhat.com>
> ---
>   qga/commands-win32.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 697c65507c..b37fa7b5ba 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -2150,10 +2150,11 @@ typedef struct _ga_win_10_0_t {
>       char const *version_id;
>   } ga_win_10_0_t;
>   
> -static ga_win_10_0_t const WIN_10_0_SERVER_VERSION_MATRIX[4] = {
> +static ga_win_10_0_t const WIN_10_0_SERVER_VERSION_MATRIX[5] = {

These arrays are NULL-terminated, they are iterated until
the NULL value is found:

    while (table->version != NULL) {

So setting their size isn't really useful.

>       {14393, "Microsoft Windows Server 2016",    "2016"},
>       {17763, "Microsoft Windows Server 2019",    "2019"},
>       {20344, "Microsoft Windows Server 2022",    "2022"},
> +    {26040, "MIcrosoft Windows Server 2025",    "2025"},
>       {0, 0}
>   };
>   

IMO this can be simplified in a preliminary patch as (untested):

-- >8 --
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index a1015757d8..c14c5cc4eb 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -2126,3 +2126,3 @@ typedef struct _ga_matrix_lookup_t {

-static ga_matrix_lookup_t const WIN_VERSION_MATRIX[2][7] = {
+static const ga_matrix_lookup_t WIN_VERSION_MATRIX[2][] = {
      {
@@ -2135,3 +2135,3 @@ static ga_matrix_lookup_t const 
WIN_VERSION_MATRIX[2][7] = {
          { 6, 3, "Microsoft Windows 8.1",    "8.1"},
-        { 0, 0, 0}
+        { }
      },{
@@ -2143,4 +2143,3 @@ static ga_matrix_lookup_t const 
WIN_VERSION_MATRIX[2][7] = {
          { 6, 3, "Microsoft Windows Server 2012 R2",     "2012r2"},
-        { 0, 0, 0},
-        { 0, 0, 0}
+        { },
      }
@@ -2154,3 +2153,3 @@ typedef struct _ga_win_10_0_t {

-static ga_win_10_0_t const WIN_10_0_SERVER_VERSION_MATRIX[4] = {
+static const ga_win_10_0_t WIN_10_0_SERVER_VERSION_MATRIX[] = {
      {14393, "Microsoft Windows Server 2016",    "2016"},
@@ -2158,9 +2157,9 @@ static ga_win_10_0_t const 
WIN_10_0_SERVER_VERSION_MATRIX[4] = {
      {20344, "Microsoft Windows Server 2022",    "2022"},
-    {0, 0}
+    { }
  };

-static ga_win_10_0_t const WIN_10_0_CLIENT_VERSION_MATRIX[3] = {
+static const ga_win_10_0_t WIN_10_0_CLIENT_VERSION_MATRIX[] = {
      {10240, "Microsoft Windows 10",    "10"},
      {22000, "Microsoft Windows 11",    "11"},
-    {0, 0}
+    { }
  };
---

Then your patch becomes a one-line one.

Regard,

Phil.


