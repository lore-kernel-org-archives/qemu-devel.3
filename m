Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF4BC44532
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 15:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmC6f-0003jA-5Q; Tue, 21 Jul 2026 11:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wmC6e-0003if-D8
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 11:10:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wmC6c-0004cb-Gs
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 11:10:04 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LDgGbp1399798
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 15:10:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 h216/Ut1PggvkXukyp1mHEZcWbwudOlhJ52hOfPWP9E=; b=FJTOQIUu+SSD2mie
 ckvK0LiWdl6/hcEDMVs6vePpFmrWalNAejVuKXppa17ZLDXAwR0b+8UgjsbdB8B+
 mhK5H8UdpPwVbnVMqNHZ+QRG4DGmUvsQzA7mUyM4i7gHffs0w/ELpuKTCTkNVIpE
 6/PGdKrgxe5af1VWjwneX6s4NZoVrZG3a0QkIvMtK22/QBxqsD32y1uo/X4ZtJwQ
 RzXps96QcS9Hz0GMHqTSMKYhdGvukwyVD3VO8erwBM4YgJ05Szxl6SnZo3yCGlKZ
 gLuaYMEkXrqxR5NxlpwV5ssQS6o+DKA4VepE9ExutOnFGQhLWbiwmeGVdx9T83BW
 KEWjmg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj1es33cd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 15:10:00 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cb6ef846b33so2163750a12.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 08:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784646600; x=1785251400; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=h216/Ut1PggvkXukyp1mHEZcWbwudOlhJ52hOfPWP9E=;
 b=SuCBJObSR0hSkgHDhIsA0sRtOlDmKOyiEMeS5wOlbOcmGzQMFiMLVuZpzs49bPg7TK
 kxEUNWRvXWOjwO8GQ+Q430brvr1fgr7S06oyx+IFmtS/1DMPB3TkKH9q94gDbktsyZRB
 nbHCIE/D2I01bSZVoAGPtlfrVhfqXUqmNrdL/h8s0+cbGy0rhNKPjhTgqMEe+SH1NhOr
 p83BHvfk3tDOGnPW1M3+IjcVlpLAAlPEuDdIIVyKp3WjmSw+p/1HrYX6WQ9l5LrP1WDP
 WJAg1DXginbL6CADJQgwuXqlUTHX2qQ/CcQQfGOOUBqjOqDqsDW6MQh0S8NCdRO2A3Vt
 aPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784646600; x=1785251400;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h216/Ut1PggvkXukyp1mHEZcWbwudOlhJ52hOfPWP9E=;
 b=L7S7sJvT3YGd6B4KJOrxRrlStiYjWA9eJopdnM4ny/Xde78F+z+wzvTF3rgHroidEz
 mky0QqSzHJo0Xirekx5bWpgdj31/1MCcfW9vyxoOWtF5GusaWk2rtpShZ0rAufY2iVzT
 Sh1axPXtH+fjeT55EFmowU4xm7h71CMoX5csqFjHTtU05pODe114K/yyjRWhL0jC6g8F
 qdhaLcyIfMUyfh/eTfidn0cRlqrxKy/nuTB+7zeVwm5Mmu6aGxiWgNokCUrZv8TpzVrs
 vghJ3NoNbd18i8sDBpvJM4LEGLeH27IEiMZxjjGKzDuS7bM4WPSvoTpcTjltll4s+VNm
 aVJg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq5ea3l+pItQsMs8SdiZBdctPQfsSKBx88Rcvoi2PqW3BPCR8hOjeTDWmk99ZFzkUaHaHspW0+N67n5@nongnu.org
X-Gm-Message-State: AOJu0Yzrq0s7XRoFVndlvfatlU3lEJUeM0UW9ekjhtI8Cr7vcJ8yj4/I
 4Gd3UZXtsruHPoiWaRu1mg+7lYB6fzo+EqydX1mHivkkejLmMRdOS8s1ULNtzeIYXTsH8qArK4s
 xCxs6eO8AIjoE877upR5nw34XiTh2mUO7l3oKdfWeCchtKL9B9fFYekuXAA==
X-Gm-Gg: AfdE7clbdn8kc82zRemAy1n5T5+7sKodo0Z36QuV2jlAnfXZuh5ZCxWkL82ONJw2T6P
 2/YcD0R+Fw/P+FlpTP2rzFG+fK9I7AOrI9sYhPq6LCRe1Jtv7ddIjb8oMKMxmb8wpr7pYweTl9v
 B7DTCWp38jYDt1tpXSe+0MTCp/ApjH8mk/V0Bp2huOCJJIrK3+xSkxK9ru8q8BusT1p4j6o5asI
 bOiIRZLIx+mpsem1KBmE3/FaN7bxa7/ki/VXsO8OsdWRDDHrb0tIcdXu+Vl8TTE4k8Db7phmwfY
 aovO9PSMviYtIdqe+F3jmwQkeE6rCvw/P4+31Qp94+YPeGkZaFqPhK3uq0HVYKD+0It8TeopQiA
 9iL02BDVS3rV5z6ll2MraE5dvYT8U6QNG9CVet2WJoGRAqoRMoPJGLCoW2y4UyXDkye9F
X-Received: by 2002:a05:6a20:c78f:b0:3bf:9bd9:cf54 with SMTP id
 adf61e73a8af0-3c42921e146mr74272637.8.1784646594906; 
 Tue, 21 Jul 2026 08:09:54 -0700 (PDT)
X-Received: by 2002:a05:6a20:c78f:b0:3bf:9bd9:cf54 with SMTP id
 adf61e73a8af0-3c42921e146mr74207637.8.1784646594331; 
 Tue, 21 Jul 2026 08:09:54 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1bb77csm53474648eec.18.2026.07.21.08.09.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 08:09:53 -0700 (PDT)
Message-ID: <50acec5e-c8cd-4aef-b35b-1b3f171695ab@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 08:09:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: fix sphinx build failure
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20260720222717.33078-1-pierrick.bouvier@oss.qualcomm.com>
 <f1a2f0b3-5548-45f2-a4b4-61c10dc8b3b4@tls.msk.ru>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <f1a2f0b3-5548-45f2-a4b4-61c10dc8b3b4@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SPZykuvH c=1 sm=1 tr=0 ts=6a5f8bc8 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=ILG-I2LR5uE-4FblJz4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: iWxV5KNTeYKLA8YSAFtw0LSFT2jy-rEX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE2MCBTYWx0ZWRfX4DPnYPPi18VZ
 3yMs4Yf13cS4jowM+UVlW+Gq9vJxFplO7rR9pSLqQkBqv+dHRjM5N1lahJ7SpBHjrroC+ViDZ8J
 encNcpvoktmZQd6HeBuceZcFYnaPeSJlbQPlYz0FPH5NhHzGIzMR9g1fx/3l7IlYSyPAPI8c8Q0
 Iif1jQO49PvcuvOkIr+C6ZRxjq8DTH40+ZSwDhThdqzNNcQ7OTYJbr5pUSpeJeRfX5LU6MUlR6J
 PRHxzQk1vXS9aQ/6rtBi5pvx9Rw3macTwxJH6U2UnbMQpS07Xmk7zfFLWfC//1W7KlQ+XTFQ5/P
 K4Ldk+ZbpiAWjD+s9GDZQQr7ZJee/MO6oeGtnSglA+0npcj8BX0VImosCxgKFsjY9LUvW5bfojG
 5/K2oZRYM0hZc1yE4DxbsNgm0AkY5J/AU4M1QLTXWcp/Ru8WiTnc106aso2jExM8gTYhNmXAN3s
 BwRgg9egFZCZtj4dKrA==
X-Proofpoint-ORIG-GUID: iWxV5KNTeYKLA8YSAFtw0LSFT2jy-rEX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE2MCBTYWx0ZWRfX9P9Nnd3FiYBW
 ViiHs+uoD1h3vxurs4tIgWTDJ1PYTIqsHIUWewpnRfDQ8UAs/nMVWWMGD9Lle3GnIqOESlhjNQk
 LLX9dFZkZlq6m2YorkaA7CGyxPv0ggc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210160
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 7/21/2026 12:51 AM, Michael Tokarev wrote:
> On 21.07.2026 01:27, Pierrick Bouvier wrote:
>> We recently started to have those failures appearing when building
>> documentation. It's hard to identify if it comes from a python, sphinx
>> or sphinx extension, but it blocks us.
>>
>> Exception occurred:
>>    File "/usr/lib/python3.13/multiprocessing/connection.py", line 399,
>> in _recv
>>      raise EOFError
>> EOFError
>> The full traceback has been saved in /tmp/sphinx-*.log, if you want to
>> report the issue to the developers.
>>
>> This seems to be the generic error message for "something went wrong in
>> sphinx multiprocess":
>> - https://github.com/sphinx-doc/sphinx/issues/11449
>> - https://github.com/sphinx-doc/sphinx/issues/14458
>> - https://github.com/sphinx-doc/sphinx/issues/8973
> 
> FWIW, this time, it looks like it is a genuine bug in debian update of
> python3.  I was able to reproduce the issue without -j option too, after
> about 300 retries (did build in a loop), and the python backtrace (it
> segfaulted) shows pattern similar to what was reported on debian.
> I haven't reproduced it after installing the fixed packages, but with
> so many attempts to failure, about 500 successful runs in a row is
> not conclusive still.
> 
>> Solve the issue by simply going back to sequential builds. We didn't
>> notice a huge speedup anyway.
> 
> The thing is: it looks like actually, at least the version of sphinx
> I have on debian stable - sphinx ignores -j option always using single
> core no matter which -j arg it is given.  I weren't able to run it in
> true parallel mode.  Maybe it spawns single "parallel" thread still,
> exploring the problematic code paths still, and without -j it wont -
> I dunno.
> 
> So, I guess, with this in mind, it should definitely be okay to have
> this change.
>

Good to know if might be fixed in the future with a python update. We
can re-include it at this time.
I can send a PR current fix once the patch has received a reviewed-by.

Regards,
Pierrick

> Thanks,
> 
> /mjt
> 
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>   docs/meson.build | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/docs/meson.build b/docs/meson.build
>> index a8d893681ec..4d8cc545fcc 100644
>> --- a/docs/meson.build
>> +++ b/docs/meson.build
>> @@ -4,7 +4,7 @@ sphinx_build =
>> find_program(fs.parent(python.full_path()) / 'sphinx-build',
>>   # Check if tools are available to build documentation.
>>   build_docs = false
>>   if sphinx_build.found()
>> -  SPHINX_ARGS = ['env', 'CONFDIR=' + qemu_confdir, sphinx_build, '-
>> q', '-j', 'auto']
>> +  SPHINX_ARGS = ['env', 'CONFDIR=' + qemu_confdir, sphinx_build, '-q']
>>     # If we're making warnings fatal, apply this to Sphinx runs as well
>>     if get_option('werror')
>>       SPHINX_ARGS += [ '-W', '-Dkerneldoc_werror=1' ]
> 


