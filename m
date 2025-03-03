Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B8AC282C6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 18:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpAtV-0003wM-LV; Mon, 03 Mar 2025 13:52:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tpAtT-0003vw-8b
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 13:51:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tpAtQ-00062X-HJ
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 13:51:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741027914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gf29dkO2JWFRU5LFZr/2hsQPWpkDCCwdgPL4OiQpspQ=;
 b=YFmxAdoInOTJJuEtPEXorl34S1BlpjcoNoeMVTb5z1Y+gRN8zR1eK5roOv31jslyilvAQa
 tfImvm89MaP/8e7WygRXyNtzEF+hYloq/LQa2O3Altlk45wDt0e1TrXCIfh4LkETHRNmPs
 9T98H7XrO8dsUBeZR7Td8eKb2rfw+Gk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-ylOSQW6tOnWN9tKLguAbvQ-1; Mon, 03 Mar 2025 13:51:51 -0500
X-MC-Unique: ylOSQW6tOnWN9tKLguAbvQ-1
X-Mimecast-MFC-AGG-ID: ylOSQW6tOnWN9tKLguAbvQ_1741027911
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3911218d81cso670434f8f.1
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 10:51:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741027911; x=1741632711;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gf29dkO2JWFRU5LFZr/2hsQPWpkDCCwdgPL4OiQpspQ=;
 b=j4yLqjAFgg4nOcRtHsDDCWIu4fzn8D3cUKWz1YPP/l+DGMyCO3vWtKs+QPbRx4QIL0
 mnweCOiC19+H9mB9EnZWJrOqG985KInaDKZW+DV/D6lPCP/ZHFW7V6uq/JBVZfhe8kQD
 iEcS1ovKfweUW0GycqbbBrW18E43qtUi45P5rFettygXd6Z0r1h5KULcxJqQVLrJBLKy
 iAIm0O8ixSeMarQUSJ/B2NPgaLOvtrG0eYamShCaPL8sSdV7PNbqF8bo9ZG027tlWDyW
 TuA6xMmfFgLUzdpGbVMJ4czs+3EEUzfev3GFZU8+BayiQ/0x7CHxP9GupRTEAF9OnC/d
 yc5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXPptvwqcgmQhJm01KmmOJQ1FkLHwleFuwE9yRFDeqfYDPATdgu/4VrLVDr9grTWCfY2mpH4aT6Zw4@nongnu.org
X-Gm-Message-State: AOJu0YxLuEMjsYw1X5eEzx4CcPmXaF0DthUk+qzkDHnmVlotKSPF7ihp
 aS8jDrAFlutsosILUrc+BqKJedr3xs5g26iNJ1Rz/8At69G+UKgBbHs3v2R+keePgGg8mWnjMTJ
 j2MExSlEa+4KAmi5ZQIdvW/HlYbBsp7PhbTtvefA6GGugyC3bVDiS
X-Gm-Gg: ASbGncs2pR3ki08P0IW6WJhyVGhuGka7CFA/oVU9EwCPPYVc1wBrRtnXWeIeMR896e4
 jz9UkWTm4LeRsklHB8+g0ybwP/zczLvmvJB87wiPVxIuXVK86MHXT+0fW0Mx8t8k7yLac4ifKTX
 3dbbnz+/4HhskA37ZAVeY4wodfcu9yQXHRFSK+2nzk3JqsyImRM5cnfNZ2/CJ/zOzhj42rCld0G
 pWwFa0yOyweh0Hx7xkM/00SGWh/Lf4uLyKoh7jweV5ah2nXqGIyRWPLrSTFdQJq4z3Zk/wY5Syq
 +ZLAfvXp60xy6GupOis=
X-Received: by 2002:a05:6000:381:b0:391:7ed:55da with SMTP id
 ffacd0b85a97d-39107ed56a2mr3437710f8f.23.1741027910711; 
 Mon, 03 Mar 2025 10:51:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQPZQbJhLmPcIIFcjZguaWNMLJiyVx1eyS3c0tWN6DdQRtOV14sThfoT/mPt2YL6Lf6Rj1oQ==
X-Received: by 2002:a05:6000:381:b0:391:7ed:55da with SMTP id
 ffacd0b85a97d-39107ed56a2mr3437700f8f.23.1741027910329; 
 Mon, 03 Mar 2025 10:51:50 -0800 (PST)
Received: from [192.168.10.48] ([151.95.119.44])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-390e4795d44sm15069237f8f.8.2025.03.03.10.51.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 10:51:49 -0800 (PST)
Message-ID: <14168384-ecdb-4c05-8267-ac5ef1c46fe9@redhat.com>
Date: Mon, 3 Mar 2025 19:51:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] util/keyval: fix msan findings
To: Peter Foley <pefoley@google.com>, Markus Armbruster <armbru@redhat.com>
Cc: Patrick Venture <venture@google.com>, peter.maydell@linaro.org,
 qemu-devel@nongnu.org
References: <20250228212039.1768614-1-venture@google.com>
 <fc1f2750-f4c7-419f-b667-301fb0bb2edf@redhat.com>
 <87frjxcjea.fsf@pond.sub.org>
 <CAAAKUPOmAHht=HgNzKvLPinfXJbWjqp=AnmQDwBEbcNFUaOetg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAAAKUPOmAHht=HgNzKvLPinfXJbWjqp=AnmQDwBEbcNFUaOetg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 3/3/25 17:32, Peter Foley wrote:
> The full output looks like:
> 
> Uninitialized bytes in strlen at offset 0 inside [0xffffd1958110, 5)
> ==9780==WARNING: MemorySanitizer: use-of-uninitialized-value
>      #0 0xaaaac1c4b170 in tdb_hash third_party/qemu/qobject/qdict.c:46:31
>      #1 0xaaaac1c4b4a4 in qdict_get third_party/qemu/qobject/qdict.c:164:36
>      #2 0xaaaac1c78468 in keyval_parse_put third_party/qemu/util/keyval.c:152:11
>      #3 0xaaaac1c77740 in keyval_parse_one third_party/qemu/util/keyval.c:295:10

In order to get to

     if (!keyval_parse_put(cur, key_in_cur, qstring_from_gstring(val),
                           key, key_end, errp)) {

you must have gone through the only exit path of the earlier
"for(;;)" loop:

         memcpy(key_in_cur, s, len);
         key_in_cur[len] = 0;
         s += len;

         if (*s != '.') {
             break;
         }

meaning that key_in_cur is NULL-terminated and initialized---unless s is
also uninitialized, but then adding an initializer would not do anything.

Paolo

>      #4 0xaaaac1c77740 in keyval_parse_into third_party/qemu/util/keyval.c:530:13
>      #5 0xaaaaba2f9524 in qemu_init third_party/qemu/system/vl.c:3322:21
>      #6 0xaaaab9641c2c in main third_party/qemu/system/main.c:54:5
>      #7 0xffffba320000 in __libc_start_main (/usr/grte/v5/lib64/libc.so.6+0x61000) (BuildId: 613d20d3b812b4c87fe9ebf8c4caae83)
>      #8 0xaaaab934bd10 in _start /usr/grte/v5/debug-src/src/csu/../sysdeps/aarch64/start.S:92
> 
>    Uninitialized value was created by an allocation of 'key_in_cur.i' in the stack frame
>      #0 0xaaaac1c7708c in keyval_parse_one third_party/qemu/util/keyval.c:190:5
>      #1 0xaaaac1c7708c in keyval_parse_into third_party/qemu/util/keyval.c:530:13
> 
> SUMMARY: MemorySanitizer: use-of-uninitialized-value third_party/qemu/qobject/qdict.c:46:31 in tdb_hash
> Exiting
> 
> 
> I don't have an easily shareable reproducer, but it's probably possible 
> to whip one up.
> 
> 
>      >> ---
>      >>  util/keyval.c | 2 +-
>      >>  1 file changed, 1 insertion(+), 1 deletion(-)
>      >> diff --git a/util/keyval.c b/util/keyval.c
>      >> index a70629a481..f33c64079d 100644
>      >> --- a/util/keyval.c
>      >> +++ b/util/keyval.c
>      >> @@ -187,7 +187,7 @@ static const char *keyval_parse_one(QDict
>     *qdict, const char *params,
>      >>  {
>      >>      const char *key, *key_end, *val_end, *s, *end;
>      >>      size_t len;
>      >> -    char key_in_cur[128];
>      >> +    char key_in_cur[128] = {};
> 
>     Suspect overkill.  Would "" do?
> 
> 
> It appears to resolve the complaint, yes.


