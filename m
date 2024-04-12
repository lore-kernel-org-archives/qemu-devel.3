Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5DEDC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 12:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvFb9-00004z-5P; Fri, 12 Apr 2024 08:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rvFay-0008TO-KY
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 08:01:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rvFau-0007Ho-GS
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 08:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712923283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4zjsK5M3JEEgnoLZCFDKn5rivr00eJ8WvSpLuW05EEU=;
 b=AcASFQ1tTTOC6GfuUa17SFaSZqVh4kjTCxKLKuP6gbtcU9HHssYNGUrU3LFHRSVEi0uliD
 yk/R7FWrzskH4vDuLRpM5vN4Oe0W7vYmZfd8N76/fYzAprRwl47lWO600p4BFXQnYLyRxk
 YK2JKEFQMwqM0AB37/Gt8XIjSEU5isE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-6ys4MKz2NzeFphbnfuIgsg-1; Fri, 12 Apr 2024 08:01:21 -0400
X-MC-Unique: 6ys4MKz2NzeFphbnfuIgsg-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-56fe1a9d358so307587a12.2
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 05:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712923280; x=1713528080;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4zjsK5M3JEEgnoLZCFDKn5rivr00eJ8WvSpLuW05EEU=;
 b=Ci9BDE8puXBtj9cWo27sVb1N+t0HO1VfpRchHZLDhGy5+UcIRgcyA8OmmmY3tO6ybn
 RJd0D5Wt3sq/6jHXM1gRKgT4gmvzNQWSpDMisQd3GDJU7uHlHoRaVMORzRHbWushYjaq
 BcdMgIuLF/rsZvelYRFvqtQJE+yGJj45zFSWeN5FBXV18MAqcGR/eBkX6FVV9F+oJBUV
 ZoPnfRzPlmMzibC92IPW985bmnTE358jMfX2qbxg5YVa76P5LeYsiN2yGvA/htoJRcrT
 fjcaGAPOcNOZkPdYPMXNrIwEm0gihcmU4GPWlZQQT3NOVqmFR01XU8dsF8Bh4qfI+3ft
 thpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2WIfeE9Tjk7Cgo8WPQS6VmdORTBQQo44ogci+bystdaq/OZJ+H8t/6QiRDiGMaYx8GjcCSemhNcuV+TugDs9e0iyr9Xg=
X-Gm-Message-State: AOJu0YznD20HLoz3yK9dA+wAtn6jg03gRuLjS/Eu6DrHposcWeJGKUuu
 vmbvdcWViWn16xHMD6EKrlANoGGxOM0X1Ad3ZeKL9AknXO1h0+xBl5VjIrttDeRplwd2S3rM/Rb
 cZLa6Fd6MnFoEbvUxM3Z2rCBCoW9Jff1UVlTbwUI1jj+nTYX+bdvG
X-Received: by 2002:a50:9e4e:0:b0:56c:1db1:f9eb with SMTP id
 z72-20020a509e4e000000b0056c1db1f9ebmr2054450ede.19.1712923280388; 
 Fri, 12 Apr 2024 05:01:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGs2Xqzuyg7xOEoqtBf8gCTgL2TN7WeCRPfU3bUZmkyKgQTNGeawqXAZUPM2kBT7l+inOurfg==
X-Received: by 2002:a50:9e4e:0:b0:56c:1db1:f9eb with SMTP id
 z72-20020a509e4e000000b0056c1db1f9ebmr2054319ede.19.1712923278305; 
 Fri, 12 Apr 2024 05:01:18 -0700 (PDT)
Received: from [192.168.10.81] ([176.206.87.39])
 by smtp.googlemail.com with ESMTPSA id
 g1-20020aa7c841000000b0057000ecadb0sm366044edt.8.2024.04.12.05.01.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 05:01:17 -0700 (PDT)
Message-ID: <e73be5a4-daca-42c7-ad82-88c76f41adec@redhat.com>
Date: Fri, 12 Apr 2024 14:01:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 4/9] Bump minimum glib version to v2.66
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Lieven <pl@kamp.de>, "Richard W.M. Jones" <rjones@redhat.com>,
 qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Konstantin Kostiuk <kkostiuk@redhat.com>,
 qemu-block@nongnu.org
References: <20240328140607.2433889-1-thuth@redhat.com>
 <20240328140607.2433889-5-thuth@redhat.com>
 <CABgObfYb-b7vaNaaESO-K_Q1vWomUaSNudmdA6JX6sj6mVkAFQ@mail.gmail.com>
 <7762cbe9-7cf0-4c98-8b3b-5e347966a81d@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <7762cbe9-7cf0-4c98-8b3b-5e347966a81d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.103,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/12/24 12:58, Thomas Huth wrote:
> On 12/04/2024 12.16, Paolo Bonzini wrote:
>> On Thu, Mar 28, 2024 at 3:06 PM Thomas Huth <thuth@redhat.com> wrote:
>>>
>>> Now that we dropped support for CentOS 8 and Ubuntu 20.04, we can
>>> look into bumping the glib version to a new minimum for further
>>> clean-ups. According to repology.org, available versions are:
>>>
>>>   CentOS Stream 9:       2.66.7
>>>   Debian 11:             2.66.8
>>>   Fedora 38:             2.74.1
>>>   Freebsd:               2.78.4
>>>   Homebrew:              2.80.0
>>>   Openbsd:               2.78.4
>>>   OpenSuse leap 15.5:    2.70.5
>>>   pkgsrc_current:        2.78.4
>>>   Ubuntu 22.04:          2.72.1
>>>
>>> Thus it should be safe to bump the minimum glib version to 2.66 now.
>>> Version 2.66 comes with new functions for URI parsing which will
>>> allow further clean-ups in the following patches.
>>
>> Missing:
>>
>> diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c
>> index b0e0b1d674f..cc1f5a708e4 100644
>> --- a/qga/commands-posix-ssh.c
>> +++ b/qga/commands-posix-ssh.c
>> @@ -288,7 +288,6 @@ qmp_guest_ssh_get_authorized_keys(
>>   }
>>
>>   #ifdef QGA_BUILD_UNIT_TEST
>> -#if GLIB_CHECK_VERSION(2, 60, 0)
>>   static const strList test_key2 = {
>>       .value = (char *)"algo key2 comments"
>>   };
>> @@ -484,11 +483,4 @@ int main(int argc, char *argv[])
>>
>>       return g_test_run();
>>   }
>> -#else
>> -int main(int argc, char *argv[])
>> -{
>> -    g_test_message("test skipped, needs glib >= 2.60");
>> -    return 0;
>> -}
>> -#endif /* GLIB_2_60 */
>>   #endif /* BUILD_UNIT_TEST */
> 
> Indeed! And there seems to be another GLIB_CHECK_VERSION(2,62,0) check 
> in util/error-report.c which we likely can clean up now, too!

Ok, I'll squash the above and

diff --git a/util/error-report.c b/util/error-report.c
index 6e44a557321..1b17c11de19 100644
--- a/util/error-report.c
+++ b/util/error-report.c
@@ -172,18 +172,8 @@ static void print_loc(void)
  static char *
  real_time_iso8601(void)
  {
-#if GLIB_CHECK_VERSION(2,62,0)
      g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
-    /* ignore deprecation warning, since GLIB_VERSION_MAX_ALLOWED is 2.56 */
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
      return g_date_time_format_iso8601(dt);
-#pragma GCC diagnostic pop
-#else
-    GTimeVal tv;
-    g_get_current_time(&tv);
-    return g_time_val_to_iso8601(&tv);
-#endif
  }
  
  /*

then.  As an aside, we probably can also drop:

             /*
              * gtk_widget_set_double_buffered() was deprecated in 3.14.
              * It is required for opengl rendering on X11 though.  A
              * proper replacement (native opengl support) is only
              * available in 3.16+.  Silence the warning if possible.
              */
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
             gtk_widget_set_double_buffered(vc->gfx.drawing_area, FALSE);
#pragma GCC diagnostic pop


and


#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
     /*
      * check if RBD image is a clone (= has a parent).
      *
      * rbd_get_parent_info is deprecated from Nautilus onwards, but the
      * replacement rbd_get_parent is not present in Luminous and Mimic.
      */
     if (rbd_get_parent_info(s->image, NULL, 0, NULL, 0, NULL, 0) != -ENOENT) {
         return status;
     }
#pragma GCC diagnostic pop


(Nautilus is Ceph 14, it's in all of CentOS Stream 9, Ubuntu 20.04 and
Debian 11) but I have no idea what the replacement would be. :/

Paolo


