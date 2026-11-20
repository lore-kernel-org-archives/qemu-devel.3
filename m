Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6327606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 13:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUOK0-0000du-4U; Fri, 20 Nov 2026 08:06:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xUOJn-0000Wr-BM; Fri, 20 Nov 2026 08:06:20 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xUOJl-0003TF-7f; Fri, 20 Nov 2026 08:06:19 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 528B560E018;
 Fri, 20 Nov 2026 14:06:14 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 03S7m7HHy9iX; Fri, 20 Nov 2026 14:06:12 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2E69C60CCE7; Fri, 20 Nov 2026 14:06:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2C44C13C28F;
 Fri, 20 Nov 2026 14:06:12 +0100 (CET)
Date: Fri, 20 Nov 2026 14:06:12 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, 
 Niek Linnenbank <nieklinnenbank@gmail.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-ppc@nongnu.org, 
 Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, 
 Eric Farman <farman@linux.ibm.com>
Subject: Re: [PATCH 05/12] tests/functional: check if we are served an Anubis
 challenge
In-Reply-To: <d86d11b2-cb7c-c128-68be-1461cca4b42d@eik.bme.hu>
Message-ID: <4b5c4160-8a41-7e23-2bba-0bee630363d8@eik.bme.hu>
References: <20261120121458.3723625-1-berrange@redhat.com>
 <20261120121458.3723625-6-berrange@redhat.com>
 <d86d11b2-cb7c-c128-68be-1461cca4b42d@eik.bme.hu>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-724319604-1795179972=:44479"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-724319604-1795179972=:44479
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 20 Nov 2026, BALATON Zoltan wrote:
> On Fri, 20 Nov 2026, Daniel P. Berrangé wrote:
>> If we get an Anubis challenge, we'll detect the problem as a mismatched
>> sha256 digest, however, it is difficult to diagnose that Anubis was the
>> root cause. Add a crude check to detect the challenge and give a clear
>> message in the logs when the download fails.
>> 
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>> ---
>> tests/functional/qemu_test/asset.py | 9 +++++++++
>> 1 file changed, 9 insertions(+)
>> 
>> diff --git a/tests/functional/qemu_test/asset.py 
>> b/tests/functional/qemu_test/asset.py
>> index ffa01aba2fb..bb7c7d5bb8f 100644
>> --- a/tests/functional/qemu_test/asset.py
>> +++ b/tests/functional/qemu_test/asset.py
>> @@ -244,6 +244,15 @@ def fetch(self):
>>             self.log.debug("Unable to set xattr on %s: %s", tmp_cache_file, 
>> e)
>>
>>         if not self._check(tmp_cache_file):
>> +            # Open in binary mode in case the file is binary
>> +            # content that can't decode as valid utf-8
>> +            with open(tmp_cache_file, mode='rb') as fh:
>> +                f = fh.read(10*1024)
>> +                if "anubis".encode() in f:
>> +                    tmp_cache_file.unlink()
>> +                    raise AssetError(self,
>> +                                     f"Got Anubis challenge instead of 
>> content",
>> +                                     transient=True)
>>             tmp_cache_file.unlink()
>
> I don't know python but there's already tmp_cache_file.unlink() here. Is the 
> one above needed too?

I got it, raise exits so need to unlink before.

Regards,
BALATON Zoltan

>>             raise AssetError(self, f"Hash does not match {self.hash}")
>>         tmp_cache_file.replace(self.cache_file)
>
--3866299591-724319604-1795179972=:44479--

