Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE7AC54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 11:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhSx7-0006HG-E6; Tue, 05 Mar 2024 06:27:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1rhSwy-0006Bn-Hs
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:27:13 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1rhSww-0000Od-6W
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:27:12 -0500
Received: (qmail 1104 invoked by uid 484); 5 Mar 2024 11:27:07 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.438335 secs); 05 Mar 2024 11:27:07 -0000
Received: from nedpc1.intern.lauterbach.com (HELO [10.2.11.92])
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP
 for <alex.bennee@linaro.org>; 5 Mar 2024 11:27:05 -0000
Content-Type: multipart/alternative;
 boundary="------------poDwcZuC8AvIjdD02mCqXUaW"
Message-ID: <a4ec2e38-d804-4b6b-95a9-5353f3b93795@lauterbach.com>
Date: Tue, 5 Mar 2024 12:27:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/18] gdbstub: DebugClass added to system mode.
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Christian Boenig <christian.boenig@lauterbach.com>
References: <20231220162555.19545-1-nicolas.eder@lauterbach.com>
 <20231220162555.19545-5-nicolas.eder@lauterbach.com>
 <8734tb8bz4.fsf@draig.linaro.org>
From: "nicolas.eder@lauterbach.com" <nicolas.eder@lauterbach.com>
In-Reply-To: <8734tb8bz4.fsf@draig.linaro.org>
Received-SPF: pass client-ip=62.154.241.196;
 envelope-from=nicolas.eder@lauterbach.com; helo=smtp1.lauterbach.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

This is a multi-part message in MIME format.
--------------poDwcZuC8AvIjdD02mCqXUaW
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alex,

I managed to include all of your feedback except for the one on this patch:

> You shouldn't need empty functions if you are not using them. Moreover
> you should use the inheritance feature and have something like:
>
> static void gdb_debug_class_init(ObjectClass *klass, void *data)
> {
>      DebugClass *dc = DEBUG_CLASS(klass);
>      dc->set_stop_cpu = gdb_set_stop_cpu;
> };
>
> static const TypeInfo debug_info[] = {
>      {
>          .name = TYPE_DEBUG,
>          .parent = TYPE_OBJECT,
>          .instance_size = sizeof(DebugState),
>          .class_size = sizeof(DebugClass),
>          .abstract = true,
>      },
>      {
>          .name = TYPE_GDB_DEBUG,
>          .parent = TYPE_DEBUG,
>          .class_init = gdb_debug_class_init,
>      },
> };
>
> DEFINE_TYPES(debug_info)

My approach was to delete debug/common/debug.c and put the above code 
into debug/gdbstub/system.c and an analog version for MCD in 
debug/mcdstub/mcdstub.c. However, I don't know when to store the 
DebugClass to the MachineState (MachineState *ms = 
MACHINE(qdev_get_machine()); ms->debug_class = dc;). It doesn't seem to 
work when inside of gdb_debug_class_init().

I still lack an understanding of when/how exactly gdb_debug_class_init() 
is called.

Was my approach wrong and when should I store the DebugClass?

Best regards,

Nicolas

--------------poDwcZuC8AvIjdD02mCqXUaW
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi Alex,</p>
    <p>I managed to include all of your feedback except for the one on
      this patch:<br>
    </p>
    <span style="white-space: pre-wrap">
</span><span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:8734tb8bz4.fsf@draig.linaro.org">
      <pre class="moz-quote-pre" wrap="">You shouldn't need empty functions if you are not using them. Moreover
you should use the inheritance feature and have something like:

static void gdb_debug_class_init(ObjectClass *klass, void *data)
{
    DebugClass *dc = DEBUG_CLASS(klass);
    dc-&gt;set_stop_cpu = gdb_set_stop_cpu;
};

static const TypeInfo debug_info[] = {
    {
        .name = TYPE_DEBUG,
        .parent = TYPE_OBJECT,
        .instance_size = sizeof(DebugState),
        .class_size = sizeof(DebugClass),
        .abstract = true,
    },
    {
        .name = TYPE_GDB_DEBUG,
        .parent = TYPE_DEBUG,
        .class_init = gdb_debug_class_init,
    },
};

DEFINE_TYPES(debug_info)<span style="white-space: pre-wrap">
</span></pre>
    </blockquote>
    <p>My approach was to delete <span style="white-space: pre-wrap">debug/common/debug.c and put the above code into debug/gdbstub/system.c and an analog version for MCD in debug/mcdstub/mcdstub.c. However, I don't know when to store the DebugClass to the MachineState (MachineState *ms = MACHINE(qdev_get_machine()); ms-&gt;debug_class = dc;). It doesn't seem to work when inside of gdb_debug_class_init().</span></p>
    <p><span style="white-space: pre-wrap">I still lack an understanding of when/how </span><span
      style="white-space: pre-wrap">exactly gdb_debug_class_init() is called</span><span
      style="white-space: pre-wrap">.</span></p>
    <p><span style="white-space: pre-wrap">
</span></p>
    <p><span style="white-space: pre-wrap">Was my approach wrong and when should I store the DebugClass?</span></p>
    <p><span style="white-space: pre-wrap">
</span></p>
    <p><span style="white-space: pre-wrap">Best regards,</span></p>
    <p><span style="white-space: pre-wrap">Nicolas
</span></p>
    <p><span style="white-space: pre-wrap">
</span></p>
  </body>
</html>

--------------poDwcZuC8AvIjdD02mCqXUaW--

