Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA26CF6D2D
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 15:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sw0tX-0007TL-SC; Wed, 02 Oct 2024 11:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1sw0tW-0007TC-6A
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 11:04:02 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1sw0tT-0002xr-VM
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 11:04:01 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8F6E4948EF;
 Wed,  2 Oct 2024 18:03:18 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2E16B14B085;
 Wed,  2 Oct 2024 18:03:57 +0300 (MSK)
Message-ID: <6035f465-e118-4ba4-8558-e5d3fb4060e9@tls.msk.ru>
Date: Wed, 2 Oct 2024 18:03:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/elfload.c: keep GNU0_MAGIC in host byte order
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
References: <20241002091119.995467-1-mjt@tls.msk.ru>
 <b7b893d6-48b5-4eb5-95e4-50af746ddf4f@vivier.eu>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 xsBLBETIiwkBCADh3cFB56BQYPjtMZCfK6PSLR8lw8EB20rsrPeJtd91IoNZlnCjSoxd9Th1
 bLUR8YlpRJ2rjc6O1Bc04VghqUOHgS/tYt8vLjcGWixzdhSLJgPDK3QQZPAvBjMbCt1B6euC
 WuD87Pv5Udlpnzf4aMwxkgfTusx+ynae/o+T5r7tXD+isccbC3SiGhmAPxFyY3zGcFk4+Rxc
 0tP8YY2FWE/baHu+lBDTUN79efWAkHhex1XzVZsV7ZD16rzDbXFK5m6ApvGJWlr5YDEEydTF
 WwmvwBfr4OINVxzEG/ujNiG4fpMf2NsnFGyB9aSbFjXZevB4qWkduYYW+xpK1EryszHtAAYp
 zSBNaWNoYWVsIFRva2FyZXYgPG1qdEB0bHMubXNrLnJ1PsLAlgQTAQoAQAIbAwYLCQgHAwIE
 FQIIAwQWAgMBAh4BAheAAhkBFiEEbuGV0Yhuj/uBDUMkRXzgoIBEZcUFAmBbcjwFCS5e6jMA
 CgkQRXzgoIBEZcUTIQgA1hPsOF82pXxbcJXBMc4zB9OQu4AlnZvERoGyw7I2222QzaN3RFuj
 Fia//mapXzpIQNF08l/AA6cx+CKPeGnXwyZfF9fLa4RfifmdNKME8C00XlqnoJDZBGzq8yMy
 LAKDxl9OQWFcDwDxV+irg5U3fbtNVhvV0kLbS2TyQ0aU5w60ERS2NcyDWplOo7AOzZWChcA4
 UFf78oVdZdCW8YDtU0uQFhA9moNnrePy1HSFqduxnlFHEI+fDj/TiOm2ci48b8SBBJOIJFjl
 SBgH8+SfT9ZqkzhN9vh3YJ49831NwASVm0x1rDHcIwWD32VFZViZ3NjehogRNH9br0PSUYOC
 3s7ATQRX2BjLAQgAnak3m0imYOkv2tO/olULFa686tlwuvl5kL0NWCdGQeXv2uMxy36szcrh
 K1uYhpiQv4r2qNd8BJtYlnYIK16N8GBdkplaDIHcBMbU4t+6bQzEIJIaWoq1hzakmHHngE2a
 pNMnUf/01GFvCRPlv3imkujE/5ILbagjtdyJaHF0wGOSlTnNT4W8j+zPJ/XK0I5EVQwtbmoc
 GY62LKxxz2pID6sPZV4zQVY4JdUQaFvOz1emnBxakkt0cq3Qnnqso1tjiy7vyH9CAwPR/48W
 fpK6dew4Fk+STYtBeixOTfSUS8qRS/wfpUeNa5RnEdTtFQ9IcjpQ/nPrvJJsu9FqwlpjMwAR
 AQABwsBlBBgBCAAPBQJX2BjLAhsMBQkSzAMAAAoJEEV84KCARGXFUKcH/jqKETECkbyPktdP
 cWVqw2ZIsmGxMkIdnZTbPwhORseGXMHadQODayhU9GWfCDdSPkWDWzMamD+qStfl9MhlVT60
 HTbo6wu1W/ogUS70qQPTY9IfsvAj6f8TlSlK0eLMa3s2UxL2oe5FkNs2CnVeRlr4Yqvp/ZQV
 6LXtew4GPRrmplUT/Cre9QIUqR4pxYCQaMoOXQQw3Y0csBwoDYUQujn3slbDJRIweHoppBzT
 rM6ZG5ldWQN3n3d71pVuv80guylX8+TSB8Mvkqwb5I36/NAFKl0CbGbTuQli7SmNiTAKilXc
 Y5Uh9PIrmixt0JrmGVRzke6+11mTjVlio/J5dCM=
In-Reply-To: <b7b893d6-48b5-4eb5-95e4-50af746ddf4f@vivier.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

02.10.2024 16:51, Laurent Vivier wrote:
> Le 02/10/2024 à 11:11, Michael Tokarev a écrit :
>> Other places of this file operate in host byte order.  Only
>> this constant is defined as little-endian.  This does not
>> work, for example, on s390x host when running an arm64 binary:
>>
>>   qemu-arm64: /usr/bin/busybox: Invalid note in PT_GNU_PROPERTY
>>
>> This change is tested on all combinations of host/guest for
>> which debian provides release architectures, namely:
>>
>>    amd64 arm64 armel armhf i386 mips64el ppc64el riscv64 s390x

Actually this is wrong.  The only architecture on debian where this
.note.gnu.property field is actually used is aarch64.  On all other
architectures, this code path is not tested.  But for aarch64 binary
I actually tested on all (host) architectures listed above.  I should
update the commit comment.

Thanks,

/mjt

