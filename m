Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2574ECC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 17:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPc6-0000qm-Si; Thu, 15 Oct 2026 13:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHPc3-0000qO-UH
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 13:51:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHPc0-0007z1-AK
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 13:51:30 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FFA3eB4077444
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 17:51:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dRqxw9f9teuirx7W/SjZba8EX6fexkV8rYH1nfMuuvw=; b=K4jR8nl2yOEGsFls
 WvBKgEJkGk6Iy8Yj4hQndWpelxyst5FzBzuRSIbu+EqXAvBB9UGd2bYzNAbi6+5g
 K72sVcl2xhfCwCzIeqhaQWcmYOZJObrUnLHpgHhMUv1JcK73QSJSfqvPXq/di8xq
 MWKNWLYMgy356bifHLu7Vp5IWuApmFFXgrPOyS7b2+AO4SzmXDrn76w3Dqi+uvy7
 FSRNojB8Rjlwpe6hTWC/5kKiatNJskhD/a1dxpSsHaj8QHWtrhnxdQSrTidguLfB
 lxc376KAQKbNOGLog8rt3/fc/XRsI9ihifyezXlHONYAHvOBM1H6BjI03qZojTT0
 HQbC4A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4havbc222m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 17:51:25 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-341eff9e381so15496369eec.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 10:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792086685; x=1792691485; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dRqxw9f9teuirx7W/SjZba8EX6fexkV8rYH1nfMuuvw=;
 b=bojBCktvA3FVzn1hqReDKSZInbdRfQCdNtORPZwFecjFl/m9EyidB/GPKNF2JlDpBy
 2q2qtWeNhHYRkMB4WXO13NCbMKRYg8mBTeahepNJ4N3BpR8bk+Pk4vNf0lD1PqIcyjRE
 MOWWexWJSIMk/UIJa9AQBwsMLwLebBdNB8EKMSxcuDdcKx2b+7ZLCpkfOrjE7d2VTPMi
 k/JBghwqE+99/PHdxv2Lq9EvqV+ZF0Lg5d/xvJRpc9L8dKphslPjYK4kNa4r1yU4BGPt
 2qGJSeXaYg7XF1Re8Cy8vkYJ0jQdwCDldXDO6Enxin8JmMkxVU1kJmORol16hb4mfk+h
 S0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792086685; x=1792691485;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dRqxw9f9teuirx7W/SjZba8EX6fexkV8rYH1nfMuuvw=;
 b=nPr2PCx2S/K4ZN2mxa4AvmWOL5YVpKKjROz5oqlK4lQ0oEiLKXx4HMuev9mRBKdE8y
 y1tk4AnkNukdSuTADPxKsok4VGueDRzU2k5z9TYyJNI3XucDRLpUAvgKo3GLR7xjTI+v
 FDIa3nKT5tLtX6kK3DKd1cSeVYu3BxpC2ARGrA/YXqic0GuS7yHan2EuXO5rFU7PeAGa
 8hMAcoVun8hQUc3JqsDk27QfiGNGIClitLK1ovKc2UlcTTek1qCUK5OLHL2+zZkbyvzn
 08QQprZgzXMjTX4IKItzyKk5Y4B5tSp/VJoiPSH63/IVUHKfvxs1MnselhbNZwYTACir
 vhfQ==
X-Gm-Message-State: AFq9FYK78MbTH5br/8OmjHhso2hvIsi8L7VzjuTs0yIDjL6BEhIYHJOa
 FGK9v28/ZIAOs5p/OedoOkk8j8ifP1oLkUNw5Nrp7a6ZpWWoEGdUOUgPMCnPT6/prgs9/jJPCF+
 9dPWBSR+Vktl05kkjknvQ2j2cK0kSHDUR/w9dd1k9p3S+uMWJqJd5lHXwXg==
X-Gm-Gg: AYBFou1l3L93cPWhsq0+BSfSFR3tWO8cmMIw8NXGmkF6XCqnU/BUp4lRiDW72KosiX8
 FE9ieNwnXVI5rCnYJMBNnzbT99gKzdRM0IvdpuYTMbi3bfUp2nYKDkEK9rflCjBZdOUlNOgyZMu
 0sxOzKID5BPFbKb73E2Z28RTd0uU0wc9iOsI/8NSZBkegped05WACbcluhrP3PXnSX2D4m+iwku
 M/IMnWLgpXM8AYgttsd28ZbsIupQ6Fl1GfO1aig2WGuhwQ0ZGQEyR7u1eyn6BQdbnCqh0OUrn/r
 LL5Q3OKvnGF0YEZIMgdqAd/knuyvwCaSSojE7Isxt/1kVwIFJ5VXmf7J9BDDgGw/LOoZEXOQVdU
 zZy60R3RTmrnRtFlTFMnrZg26Izaa+nlSHgP00m1NwirUKNvrrw0jfIL1WSW9AEiBPvBSXQ==
X-Received: by 2002:a05:7300:de46:b0:353:5a1e:a7e0 with SMTP id
 5a478bee46e88-3537e0aba8bmr23664628eec.32.1792086684945; 
 Thu, 15 Oct 2026 10:51:24 -0700 (PDT)
X-Received: by 2002:a05:7300:de46:b0:353:5a1e:a7e0 with SMTP id
 5a478bee46e88-3537e0aba8bmr23664581eec.32.1792086684039; 
 Thu, 15 Oct 2026 10:51:24 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36057e9906bsm485461eec.19.2026.10.15.10.51.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 10:51:23 -0700 (PDT)
Message-ID: <f6484b36-7ef5-480c-8a96-a3b38e60f977@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 10:51:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/19] multi-target: remove dump functions duplication
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>
References: <20261014234605.209084-1-pierrick.bouvier@oss.qualcomm.com>
 <atCWOW9cDfUFky13@hive.localdomain>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <atCWOW9cDfUFky13@hive.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=QbvzLcbv c=1 sm=1 tr=0 ts=6ad1129d cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=VJtcOJ0laQWng5ug2pYA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA3MSBTYWx0ZWRfX/HNUE5ETcf/e
 ndrlAQ1dsOuy1ZgP1vnpJvPjlGzAL69ECvnzvGYDrZzMtC4PBj0cmqOizQMjcvayKQLTuoX2US8
 yAypAkvjOjKD1IBT3EHVxkrJpk/YSww=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA3MSBTYWx0ZWRfXzc93zq+aAl9s
 BqaTKy/9YPvucAdqTzDkcrvAUVK6CQEkvEDDSdWS4tX4HOLGTHPtSEg9MEN0jTtcN4HCfn00KZW
 sjSt7664aLnD9VsbLEc4HVuYMZGFiHOfM1mK2/q8gx9LrdCOHDEDk1SFtqOc7F6U9MEolbemp/y
 VBXV44TWFX1Fo0EKEsIy01TYQWVE26vJlcAqGqnxIHPZrjAMEOtac4XBrCqZdCyBG/m6k50+P1G
 JLolqZY2TyInYmDCjbnhK1fXuoi21yypcZJgGv9H8HjP/d+D8tnRxJyEW/2dIzhN0U5Lb4MZFIS
 /4xmVFq8XOBhZQQcS7NEOqVvwcu6L7PSqR25qwTZobfUsJMtwrBgokmlmqJu6njVyne8TluzSkQ
 kSGme32XPrW3GIXhh7xy9o9ybhmXRVqq2DfUKgxX853SyAaIkxfvaMEYsibzLSQe7tPhTQ2aa0j
 MTc6q8dnL8yrNHAlj/g==
X-Proofpoint-ORIG-GUID: Yk1fdBy19TjSUuieo7jcg7GSH0F34q_P
X-Proofpoint-GUID: Yk1fdBy19TjSUuieo7jcg7GSH0F34q_P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150071
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

On 10/15/2026 2:08 AM, Anton Johansson wrote:
> On 15/10/26, Pierrick Bouvier wrote:
>> This series removes duplication of cpu_get_note_size and cpu_get_dump_info per
>> target. For this, we define a new set of Dump operations for a given cpu, and
>> implement it per target.
>>
>> Existing implementations were using first_cpu, which is what we continue to do.
>> When we'll work on heterogeneous later, we can revisit this to either forbid a
>> dump, or perform a dump for each target active.
>>
>> Based-on: 20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com
>> "[PATCH v3 00/12] multi-target: add hexagon"
>> This base is only needed due to conflicts with current wip, it's not important
>> for this series implementation.
> 
> I have a very similar series going locally here
> 
>   https://gitlab.com/AntonJohansson/qemu/-/commits/b4/arch-dump
> 
> where I added get_dump_info()/get_note_size() to SysemuCPUOps given
> that we already have write_elf[32|64]_note() there.  Any reason it would
> be preferable to have a new struct of function pointers?
> 
> Also I saw some uses of first_cpu in the write_elf[32|64]_note()
> functions on i386 at least that we should eliminate.
> 

It didn't cross my mind to be honest, but taking a look, yes it seems
like a good place to hold this. It even has monitor related content
already. I'll respin current series with this.

Thanks,
Pierrick

