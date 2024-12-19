Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C64EE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 18:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOLPo-0007Ip-3G; Thu, 19 Dec 2024 13:38:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOLPm-0007IB-4o
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 13:38:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOLPi-0003GS-U9
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 13:38:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734633500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uEToxiWur83dSpOktoEEZXa55rdz/uDNXPSKlWuq3h0=;
 b=iN2Xu1uNoL9SGNsUtAl8mcBadWFtSDtDY6kn8RR0DgkAPMr/e4UgIwc+bjE5brgpCGLRtt
 W2S5E0RFoelo4+/RrNfOb3bzRS48/46UYof3jgIh91GMtg+NTQqJySGZbp32zj8i7kaXdH
 qTJ71bpgPrwCM69A02jebNCnASSdNCI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-sNz2JUygMdWrHkl4xUWvbg-1; Thu, 19 Dec 2024 13:38:15 -0500
X-MC-Unique: sNz2JUygMdWrHkl4xUWvbg-1
X-Mimecast-MFC-AGG-ID: sNz2JUygMdWrHkl4xUWvbg
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-386321c8f4bso655419f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 10:38:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734633492; x=1735238292;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uEToxiWur83dSpOktoEEZXa55rdz/uDNXPSKlWuq3h0=;
 b=htAtu3yrTnuioMaBTadfvOzysvZXGpUf/ki8QzAa39/kqVvEmtyQ+UOYhSVsaqFjQj
 nFe3LSV9jv3/o0NsxYUD98+Ue4XnUf+S5XeABzF9lD7aNbQMMVRuflfxog1rXVr97HRG
 NVEjIAr7RK+y4PnD8ya7M5mJqfUZUMon616ADkJ2uHRaWAdm8aqW1pf/cA2BwYXvWac6
 UdQjF8qe7ihjuYOyV2vzGUp8s7G++t7aQ4zqWf3475iROYYM9MRKSjSIu1JqUo2bzccC
 weJqnK/aMEcZE2Y5DdIgCuR/Q0BebNVIdnTri7iYj/fUfIzAYPuotbbqAHCRgR88fV2P
 VsPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAOIgmOjjAMQICR23xv+2ct0tZZScq6ZcC17H4br6SfD18JVqZsaPghaACF1aySEevAgqI+viRP4Gr@nongnu.org
X-Gm-Message-State: AOJu0YzIJpcYyxDP6veC/jSnav6bnYKenC96inHhDs4dNwomv0i8ji+9
 fd1lmielUwmfp6Zu+H93dgJ2qK8Vzui6CyLxDR6QhGTEbkeNO1vRcC5KLtZyTPdVT9g1Ad7dTi8
 AeuLTURTUmvyDM+N68VXByQh3CoZVubBoVuQfExco7qxwK9Zj1AaL
X-Gm-Gg: ASbGncv1KC+cS2oFXdaxpqoba4xJywKcM698KlB7MU52DmsXVd/3BjzAnDdAzVSSSPV
 2J23yZFFRFRb2feEHugZ+VN0GNJpVBX0prUyK/SSftMThbdBOC69vUFgQY7CyqEvC+1PpXu5xwu
 N4NLZCi3+5osfGHmQYOHniOrTeoBYLgUCgpkfLf56C7x/iNT5/BZKNF7pKAvaSKGQPmygnLMAFP
 Er53HiscSQcTzJMEt5DWDyzOw88nGQUVYOolUEDdb83udFJLXXqrzjixil3
X-Received: by 2002:adf:ab0c:0:b0:386:37f5:99f6 with SMTP id
 ffacd0b85a97d-38a223ff225mr79787f8f.53.1734633492430; 
 Thu, 19 Dec 2024 10:38:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7gDXL6p7kkNy7P7aYsUUwaOs91EDg2NRNddxp1x1XUKpw5pDDMEvP/2ByQgVZpiCfop/gqw==
X-Received: by 2002:adf:ab0c:0:b0:386:37f5:99f6 with SMTP id
 ffacd0b85a97d-38a223ff225mr79774f8f.53.1734633491969; 
 Thu, 19 Dec 2024 10:38:11 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8a6abesm2140962f8f.90.2024.12.19.10.38.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 10:38:11 -0800 (PST)
Message-ID: <c22ccbb1-9fdc-410c-85c0-ffa91de16b09@redhat.com>
Date: Thu, 19 Dec 2024 19:38:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/42] Rust, qdev, target/i386 changes for 2024-12-19
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241219134843.443085-1-pbonzini@redhat.com>
 <e53e11b6-169f-4988-9cf1-8c5a5c79e42e@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 xsEhBFRCcBIBDqDGsz4K0zZun3jh+U6Z9wNGLKQ0kSFyjN38gMqU1SfP+TUNQepFHb/Gc0E2
 CxXPkIBTvYY+ZPkoTh5xF9oS1jqI8iRLzouzF8yXs3QjQIZ2SfuCxSVwlV65jotcjD2FTN04
 hVopm9llFijNZpVIOGUTqzM4U55sdsCcZUluWM6x4HSOdw5F5Utxfp1wOjD/v92Lrax0hjiX
 DResHSt48q+8FrZzY+AUbkUS+Jm34qjswdrgsC5uxeVcLkBgWLmov2kMaMROT0YmFY6A3m1S
 P/kXmHDXxhe23gKb3dgwxUTpENDBGcfEzrzilWueOeUWiOcWuFOed/C3SyijBx3Av/lbCsHU
 Vx6pMycNTdzU1BuAroB+Y3mNEuW56Yd44jlInzG2UOwt9XjjdKkJZ1g0P9dwptwLEgTEd3Fo
 UdhAQyRXGYO8oROiuh+RZ1lXp6AQ4ZjoyH8WLfTLf5g1EKCTc4C1sy1vQSdzIRu3rBIjAvnC
 tGZADei1IExLqB3uzXKzZ1BZ+Z8hnt2og9hb7H0y8diYfEk2w3R7wEr+Ehk5NQsT2MPI2QBd
 wEv1/Aj1DgUHZAHzG1QN9S8wNWQ6K9DqHZTBnI1hUlkp22zCSHK/6FwUCuYp1zcAEQEAAc0j
 UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT7CwU0EEwECACMFAlRCcBICGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRB+FRAMzTZpsbceDp9IIN6BIA0Ol7MoB15E
 11kRz/ewzryFY54tQlMnd4xxfH8MTQ/mm9I482YoSwPMdcWFAKnUX6Yo30tbLiNB8hzaHeRj
 jx12K+ptqYbg+cevgOtbLAlL9kNgLLcsGqC2829jBCUTVeMSZDrzS97ole/YEez2qFpPnTV0
 VrRWClWVfYh+JfzpXmgyhbkuwUxNFk421s4Ajp3d8nPPFUGgBG5HOxzkAm7xb1cjAuJ+oi/K
 CHfkuN+fLZl/u3E/fw7vvOESApLU5o0icVXeakfSz0LsygEnekDbxPnE5af/9FEkXJD5EoYG
 SEahaEtgNrR4qsyxyAGYgZlS70vkSSYJ+iT2rrwEiDlo31MzRo6Ba2FfHBSJ7lcYdPT7bbk9
 AO3hlNMhNdUhoQv7M5HsnqZ6unvSHOKmReNaS9egAGdRN0/GPDWr9wroyJ65ZNQsHl9nXBqE
 AukZNr5oJO5vxrYiAuuTSd6UI/xFkjtkzltG3mw5ao2bBpk/V/YuePrJsnPFHG7NhizrxttB
 nTuOSCMo45pfHQ+XYd5K1+Cv/NzZFNWscm5htJ0HznY+oOsZvHTyGz3v91pn51dkRYN0otqr
 bQ4tlFFuVjArBZcapSIe6NV8C4cEiSTOwE0EVEJx7gEIAMeHcVzuv2bp9HlWDp6+RkZe+vtl
 KwAHplb/WH59j2wyG8V6i33+6MlSSJMOFnYUCCL77bucx9uImI5nX24PIlqT+zasVEEVGSRF
 m8dgkcJDB7Tps0IkNrUi4yof3B3shR+vMY3i3Ip0e41zKx0CvlAhMOo6otaHmcxr35sWq1Jk
 tLkbn3wG+fPQCVudJJECvVQ//UAthSSEklA50QtD2sBkmQ14ZryEyTHQ+E42K3j2IUmOLriF
 dNr9NvE1QGmGyIcbw2NIVEBOK/GWxkS5+dmxM2iD4Jdaf2nSn3jlHjEXoPwpMs0KZsgdU0pP
 JQzMUMwmB1wM8JxovFlPYrhNT9MAEQEAAcLBMwQYAQIACQUCVEJx7gIbDAAKCRB+FRAMzTZp
 sadRDqCctLmYICZu4GSnie4lKXl+HqlLanpVMOoFNnWs9oRP47MbE2wv8OaYh5pNR9VVgyhD
 OG0AU7oidG36OeUlrFDTfnPYYSF/mPCxHttosyt8O5kabxnIPv2URuAxDByz+iVbL+RjKaGM
 GDph56ZTswlx75nZVtIukqzLAQ5fa8OALSGum0cFi4ptZUOhDNz1onz61klD6z3MODi0sBZN
 Aj6guB2L/+2ZwElZEeRBERRd/uommlYuToAXfNRdUwrwl9gRMiA0WSyTb190zneRRDfpSK5d
 usXnM/O+kr3Dm+Ui+UioPf6wgbn3T0o6I5BhVhs4h4hWmIW7iNhPjX1iybXfmb1gAFfjtHfL
 xRUr64svXpyfJMScIQtBAm0ihWPltXkyITA92ngCmPdHa6M1hMh4RDX+Jf1fiWubzp1voAg0
 JBrdmNZSQDz0iKmSrx8xkoXYfA3bgtFN8WJH2xgFL28XnqY4M6dLhJwV3z08tPSRqYFm4NMP
 dRsn0/7oymhneL8RthIvjDDQ5ktUjMe8LtHr70OZE/TT88qvEdhiIVUogHdo4qBrk41+gGQh
 b906Dudw5YhTJFU3nC6bbF2nrLlB4C/XSiH76ZvqzV0Z/cAMBo5NF/w=
In-Reply-To: <e53e11b6-169f-4988-9cf1-8c5a5c79e42e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

On 12/19/24 19:27, Richard Henderson wrote:
> Please, really, replace my constify series with v2.

Sure, sorry about that.  I squashed this difference in from v1's final result:

diff --git b/include/hw/qdev-core.h a/include/hw/qdev-core.h
index c404bf55550..e6ef80b7fd0 100644
--- b/include/hw/qdev-core.h
+++ a/include/hw/qdev-core.h
@@ -947,8 +947,8 @@ char *qdev_get_own_fw_dev_path_from_handler(BusState *bus, DeviceState *dev);
   * you attempt to add an existing property defined by a parent class.
   * To modify an inherited property you need to use????
   *
- * Validate that @props has at least one Property plus the terminator.
- * Validate that @props is an array via ARRAY_SIZE.
+ * Validate that @props has at least one Property.
+ * Validate that @props is an array, not a pointer, via ARRAY_SIZE.
   * Validate that the array does not have a legacy terminator at compile-time;
   * requires -O2 and the array to be const.
   */


and this one because otherwise clippy complains:

diff --git b/rust/qemu-api/src/device_class.rs a/rust/qemu-api/src/device_class.rs
index cca51fe1a98..c98f0b2c7da 100644
--- b/rust/qemu-api/src/device_class.rs
+++ a/rust/qemu-api/src/device_class.rs
@@ -87,7 +87,7 @@ fn vmsd() -> Option<&'static VMStateDescription> {
              dc.vmsd = vmsd;
          }
          let prop = <T as DeviceImpl>::properties();
-        if prop.len() != 0 {
+        if !prop.is_empty() {
              bindings::device_class_set_props_n(dc, prop.as_ptr(), prop.len());
          }
      }

Paolo


