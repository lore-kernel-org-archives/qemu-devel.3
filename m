Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8882FC61DF0
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 03:34:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0smJ-0004ov-JI; Sun, 30 Aug 2026 23:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <colazcyg@gmail.com>)
 id 1x0smI-0004om-Bg
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 23:33:46 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <colazcyg@gmail.com>)
 id 1x0smG-0006J7-S9
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 23:33:46 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-38dc4553f62so4259298a91.0
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 20:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788147223; x=1788752023; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xukSoDEackuZJIcqxjnplNmhJaJvyOx46I2D+cw+J7Y=;
 b=ocaQz4fBGwtJDVI0AG1UW5jgsj/UIoGNy4lBLvdetdI1G5RkxBXJqx6uV8jk+8/2Ra
 1DGW3XR12dUZ1ot6jyIq0uXET7PhardLQId5w1paypbCWVSi3WJZ3AJV/dcv2XfISXn6
 8VVve2BnZH5zsV3B3BTNW/acn7/kBvczhEG9cE3+hriotr2WHiAD7jFt8hegQTFCfoUD
 C50igH/769MFAIAfCquACFFqV2L9xV8ssMfOpS3xbB69Jyx9SO5h2KqT/A7oqPw8mJlN
 OzeLfGjMls4BTAIFphnKgV4vTR470sj8j09qHw+hY4uYcJA7eye3yZAsWlUokSkcQyrB
 Dlqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788147223; x=1788752023;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xukSoDEackuZJIcqxjnplNmhJaJvyOx46I2D+cw+J7Y=;
 b=jfs758xuET75jsKj4A8s4vEiwDPqSP38ARxFnY6bzbEKM3pg/7zS0kv+/ZLzBogPVZ
 FsZ6i9PzigsiYFoQFi3LbwIEIq6yoU1fOYJ4P3bQHo6U23P9O7Nv+4pvavy5UYoSfglK
 qdjcdf3slPVciUDRVTAhbkd3wBCOCsyytB0lEVDQV2xnfZzKdcGnJK0VfwMIkrf/9m1N
 nvMWgBuv88xT4bSypAUvpTAmNbZCVti86R08DnZetYAULOtoz5U4dd2Db0rGHiXbFIfU
 waUy6RhjRiKNhfvhg9h7kGKOByePzmUsbj8JjbJtmfYRMrAckg3oVWVe/dynSpnC9fjP
 fcow==
X-Gm-Message-State: AFuF++nCZA4kjQqcgMjm73FY8g6NBgWFTZGXxaN1n7TNK88/+AmMJhUK
 utCOry1Tpw16OmDJKv9kSHgLjq1E9OOeSu2DAJM9VqaitAEpUV+EU7d4
X-Gm-Gg: AYBFou1AGqi1s6AUvxPYzINEgXZkJK5AH/VyOrlnREGGBMQ+jH7x5yBXCKmyUlkrZUh
 UmgY/nsQUDR4lIvSlxyYypeVgAf98N7Kesh7krqOwee9QhuFqnqWqgWKGJ/M0EHXyK/U1eILQO8
 7rysdK9LknBPUL1o2A0mA3aMuRnGmS8g10z/xnPUwoG3fvcT3Qo1bxfRIbJYDia/buftfV85sQG
 Eg4KY0MfI0N7fUZkjTYsOea/aLvyUpsJdLZaJjgm6FEcO+84U7nZqQOgH4MdU45zuaRKZ1y+oq6
 5sNA6npldmHSiDB7yhKAFgm0hU0Da0LFErLG4ya0kwi5NHX4q+InjCRyQAVnv64QmuGV3WiaMjA
 w0+nuEji1SDMnHuPYy14jVQgRU2ag6a7n4hV9IoMfgmvuYf8DDTm/ggirTQAwCGdNWidAu7saqB
 M1boemrXgVWRycvERa9C06bms93reUExxhwWcgtWhL/JrURneJoGcBP1cHVJ3Vvsu7oa1zsd8=
X-Received: by 2002:a17:90b:5866:b0:398:e73e:5a13 with SMTP id
 98e67ed59e1d1-398e73e5e33mr4901635a91.9.1788147223209; 
 Sun, 30 Aug 2026 20:33:43 -0700 (PDT)
Received: from ?IPV6:2001:250:6001:4339::72d? ([2a09:bac5:636f:183c::26a:c4])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0d2e465sm35935525c88.4.2026.08.30.20.33.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2026 20:33:42 -0700 (PDT)
Message-ID: <62d69a7c-5b6d-4278-86bc-ec21782ffa8d@gmail.com>
Date: Mon, 31 Aug 2026 11:33:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 1/1] ui/dbus: add org.qemu.Display1.UIInfo interface
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20260830054641.45437-1-colazcyg@gmail.com>
 <20260830054641.45437-2-colazcyg@gmail.com>
 <CAJ+F1CJjQm4dHy5U7MbTFSLgAu5Fgu3LdHrJvkvDPQQcxPtztA@mail.gmail.com>
Content-Language: en-US
From: colazcy <colazcyg@gmail.com>
In-Reply-To: <CAJ+F1CJjQm4dHy5U7MbTFSLgAu5Fgu3LdHrJvkvDPQQcxPtztA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=colazcyg@gmail.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On 8/30/26 7:48 PM, Marc-André Lureau wrote:
>> +static bool
>> +dbus_ui_info_apply_lookup(GDBusMethodInvocation *invocation,
>> +                          GVariantDict *dict,
>> +                          const gchar *key,
>> +                          const gchar *fmt_str,
>> +                          void *res)
>> +{
>> +    if (g_variant_dict_contains(dict, key) &&
>> +        !g_variant_dict_lookup(dict, key, fmt_str, res)) {
>> +        g_dbus_method_invocation_return_error(invocation,
>> +                                              DBUS_DISPLAY_ERROR,
>> +                                              DBUS_DISPLAY_ERROR_INVALID,
>> +                                              "%s must have D-Bus signature %s",
>> +                                              key, fmt_str);
>> +        return false;
>> +    }
>> +    return true;
> A bit surprising that the function returns true for unknown/invalid keys, but ok

The function will:

* return false for invalid key-value pairs (values have the wrong type 
signature).

* return true otherwise.

So `dbus_ui_info_apply` will ignore extra keys, report errors for 
invalid key-value pairs and accept a dictionary whose keys are a subset 
of the schema keys. This behavior is expected.


> lgtm, I can pick this patch unless you want to send a non-rfc version before

Okay. This patch is my final version and you can pick it.

Thanks for your guidance.


