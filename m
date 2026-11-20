Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24A1606A325
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=E0ULtyXH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ja30GZKS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUU3g-00055N-Ft; Fri, 20 Nov 2026 14:14:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUU3e-00055F-TX
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 14:14:03 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUU3d-00065v-6y
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 14:14:02 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKEfUrJ2196487
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 19:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mUou27MRkNZnJ+WXnyePT2O3JqQMD/6Dy58JjAy92u0=; b=E0ULtyXHgTPeDw0K
 7hQ8yjHYiZ9XY3fSItKhdc9EpH1dNzuZjwf+k0a68HvzOSAEMZOMz2kyGbKxXi9k
 4qCL0qmg7OaOqdIG1BFVPpa8/OEMIGBAGWXbmPlxrWa4RvfcmAixuaERrcp2DQ3Y
 B8jxlyzd0EuQ3NdnjU0ICFu1BlAMLWgCN47GICR+yKSEDQFlWwVbA61ZqoVauO01
 J9Kh1nEcBbpcWWpdbnGUV30Oa/Sz0r1CfOZus9usp4rh10G9DjydcAzuzqbrMkQS
 I5w6nZ/Y14D6naWb8NJBMq1/cNmQfslsXyLF/Nrwgnu+8R4H645Pqx/TtfZHPyEI
 6Zb3Pg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2cd1v691-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 19:13:58 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-9210ec7cb34so38084936d6.0
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 11:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795202037; x=1795806837; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mUou27MRkNZnJ+WXnyePT2O3JqQMD/6Dy58JjAy92u0=;
 b=ja30GZKSxVqIr+lrCGk6WGA7TJyW+2mgh5m6/4RG0fKqNaEmqRjl+z7AEJWSLetfJz
 GU+/o97xKeXtEw3pBAhFfhod0dDFYl66V4o+7C+x14cCJgz2XTQr/wOlFI63vrAWwHjF
 co5LJ+K+reoOYnDRulAic4GcHV1tNZGansvUTGmG7pq002Q0jt5PwNly9Hoolbs5rF4n
 USUekz/m6Ez9M/hEtCX3CpaNWgA6qJ/zCiWm5EaMPNttCToqSq2YVAK+uZdH8gwT2PCm
 /kCPsG992JNsl8K576WoIQItm5M5Y/vIFBZHWa+Q7x/LKnEKN0+S6obrEgme4RN7Sbyy
 f28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795202037; x=1795806837;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mUou27MRkNZnJ+WXnyePT2O3JqQMD/6Dy58JjAy92u0=;
 b=WjhIBrY0HYJ/aHpRgZgDFp3qvA22If9THX++cgW3gDBQf9wxMlJW1skS6vTIaRjkG1
 KwoRSx9pr2W4gtPTBIlvpG+w98Wn9fg48hZe3Q4CLcVZdZK7lY3zI93Xq/gqQNlBS/w5
 kXYeksk9vdSKNdaHlLAv+L5gSeWMHXiapslo9o2/FePeE7lIhCJFVmXgj0EXTh/ydghw
 HEvZetnjukr5p+PT+FcOcir7nyuKHNGman/u0CBJoXE30BohPeik5GMhCUeHIAbxAS5p
 i9dzyxZA/iyOZOM7DNVkHqAKo3CYUHzUQ1Knh61/wWZrEJguBhoJIvQlFEkuwZ+q5rGr
 HxPg==
X-Forwarded-Encrypted: i=1;
 AL+hErFbOSV0LM8sr20Y8K9Tiie8DoFbGh5xXAPBGvlT6L6vDOWJ4nA/dIoI+E1mIKC7PqLGLHQlgJTCZdRp@nongnu.org
X-Gm-Message-State: APuU4Z+fScVPms6OMIZI+u30fnLWYCLCzXnVuJQKShN8Cn0kTl5nirha
 lrerw1k2MtNKv2vjSEKRbFHEmgG//L/vjrC7mWR0DoWsyV6eI0er+p/B559pGF46Smo60TClHA8
 vs+S0qu4qNE6cDUB8taiTmKVhPXbyJmfU7IwGX1UxNpcUkRb7RZ0GC+Arwg==
X-Gm-Gg: AZFdTZcVIVHkVLMv5peEsicnjBE1hlgmtn84iznBJsvRgA4HpHAzCFBVIScZItNnTxb
 aFxfL/dThM8olhRDAZf5ZLzC2F5Od+am358AAVxh8W/RNqVRgYYKOa42aNpOzOvgDqmgfMGrhSm
 xUmyOhB3zpvGOAMUO9oj1N/+H98LuyHQ2hH4mKHW6urcZQK3DUfODQSij/XtUI7kSwhVO1vPGZ9
 7nXpfamRjYtu+8b7MMB6fadONZe/ybb1ihn6Ui/HzcRk3m5TBy1ViYzCA6+PdEasWyfqY7t8D+/
 Gk28BI8FdwFqlrwDvNHvqmXWONdqPNY0zaQGwgJqFKEBMUJA0eFo85uTpjLbgJhItYxxu3Dqx99
 TK9PIV706Zqvf67l4IQOalZWWVtrWKWsSbL0GiXMzPGNb8f/dVwSrlDaeb7Jv9OQaeuhqFbLUqh
 me/CIV54/wcLIYnrC5qGR1MfvslkJ9S7i0KoH1Rw==
X-Received: by 2002:a05:6214:478b:b0:921:1313:f2da with SMTP id
 6a1803df08f44-92134ade3fcmr59428086d6.32.1795202037487; 
 Fri, 20 Nov 2026 11:13:57 -0800 (PST)
X-Received: by 2002:a05:6214:478b:b0:921:1313:f2da with SMTP id
 6a1803df08f44-92134ade3fcmr59427846d6.32.1795202037095; 
 Fri, 20 Nov 2026 11:13:57 -0800 (PST)
Received: from [10.222.168.147] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9213514d20esm31128466d6.23.2026.11.20.11.13.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Nov 2026 11:13:56 -0800 (PST)
Message-ID: <4813c0d7-77e7-408d-b2cc-b631cf9b9771@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 13:13:53 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.2 00/14] Hexagon: fix systests + migration
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20261119201603.2377989-1-brian.cain@oss.qualcomm.com>
 <87mrr3smk6.fsf@suse.de>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <87mrr3smk6.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Dt/Da2/+ c=1 sm=1 tr=0 ts=6b009bf6 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=bByabl26BFGDlYZVpLMA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: c6LLzVf7h0zRnLEocYA2z9q1Hc-6ljOL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfX9gDNevNzO/rj
 ascnAv9Lrqvjz0aF+HoSsDLwMQ3eOmgg/6+kouFWE+f7FCkdRQZY5id6idujG8+Nb+uYihR9Feb
 Qre2yybjnsNvnAers+GQR8j7Zb+j1M+C5GWKwWXpf3itBUrIpPJUW8T/SaI24UHpc3d9OXAt7ni
 YIlNfHJ+fL9ja1f+HG08klgCKk990f9xGmF8jwyGM203/h3omyBc46LZW/wioa+lWGIg8uRh2dF
 U7jpuRxgtHKYyL4w7CmfaTuCxWSGUYpfmZ8lOki6JpPYxVx1CIhLzmQHcUNBTU8OKT+mSYX2Uj4
 hZ5m5zM5LTF/ToM42cZzcdKfYoMTXRQADVfgbx5YtrwjvoaDVKG9rT4tYs0bYMp6dMpBdEczt42
 cWsdOioHvg3CmpBTdSU/SvA87eXWZa5M/wANtNT0fabZcHKpp51/KsgPI7i4YDljAk2MYkV/aQu
 5Nx2+w5fmwms7ZAqmUg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfX3cefOgpA3fgP
 33SzPMb+AN+I4cSwVAI/U6cwPZtER0N6dWlZ2z6V+/aSCEn/NZgYhx/WDvQUPMS6am5DxWV6cXq
 0hNkwOQo39xmyoA9IkHd5aN1exeBNlU=
X-Proofpoint-ORIG-GUID: c6LLzVf7h0zRnLEocYA2z9q1Hc-6ljOL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200076
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/20/2026 6:40 AM, Fabiano Rosas wrote:
> Brian Cain <brian.cain@oss.qualcomm.com> writes:
>
>> The systests/arch tarballs were crafted while testing a downstream fork.
>>
>> Enabling the omitted tests revealed a few remaining bugs in 11.2.  Add
>> those tests and the associated fixes, plus a couple of fixes from Marco's
>> recent series.

>> ...

>> Let's leave the migration tests for the next cycle, please.

ok - omitted from v2.


