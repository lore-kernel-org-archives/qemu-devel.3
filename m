Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 173E0CA6017
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 21:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEvK3-0003yh-9e; Thu, 08 Oct 2026 17:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEvK1-0003yJ-Hp
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:06:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEvJz-0001FW-Vd
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:06:37 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698L0OJr3387086
 for <qemu-devel@nongnu.org>; Thu, 8 Oct 2026 21:06:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MCUWJUBGL8/XJ5WZ2BwEMObykFVJpy8nXPRqXPHE0+E=; b=O9HSaWNApwzIzvwA
 oGmhEKsUeFcvKEMMkbo5lJK1satzVblQ67W+pgMrCvHSlF1cph/xt9U/WNfaHamA
 hn0yGVmU63meEoCnQO5I75juNFl1VaFFNCfZYLs+LcdGImmo1GbBxH105Zyw8rOz
 Dci6dPAF1rBflDWOk1veB/7p0lNyCEGqeJcR81VmCt+vodRsYVu+7Nvc8/HWPwle
 ENfKaTV26IpkqkTu0U0B8rSmuQ+ACqlzyC9k7AbLVRqu0HdvSycDtFAifRieFDqT
 x+em4t0g1bjBpvZGzfver3hRwnguopQQxFgw1XSvHzjaIHWm47emZq6s/KINhNG0
 fMB43Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxrrnx0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 21:06:33 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-313d1015161so16336207eec.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 14:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791493593; x=1792098393; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MCUWJUBGL8/XJ5WZ2BwEMObykFVJpy8nXPRqXPHE0+E=;
 b=BpE2HKQkjofQv1xHIA3zPHq9IPw72xrVTmy1iC/hhSvF9r9lInQdoI26m0rNbHPUcv
 VHoZvw0ZZ5GHdSUNJBfAOBf4FsFFr1ubQQY8SnK0j7klDPXa5ZmVDMpiy13UPIQVzdPL
 7FF6S3kAPoKeL4z4tJD8c/E3HuSf8zYJkBZDnF/Rj91/Visqf8XsynF+zvpQZVv0CavY
 CStCjyAfZAq+3K29+l0+NC8HXxqrK4NFQIntVrCM7PxLlKAEfr4S819DI/wbfxCyQXR2
 DwPebYzATd2xbVRGQM6s8pjXutBnacb4e8LN7h/wF2hIfQWzsmVImLyhQjmWIEgFXMII
 FrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791493593; x=1792098393;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MCUWJUBGL8/XJ5WZ2BwEMObykFVJpy8nXPRqXPHE0+E=;
 b=KwRHAx63OpnZxHg527nGR0QCtJGL3d0sb5LI33pQzbzOZ2UBz9F78SFyoso7PmkD+B
 IgQpCA/ZVDMXJAiS3l+Uqt/T5r+8zxaDakwa5wL4tG/kwv1vee/lRhIKFBtMLMtR9xqh
 TvGyTEHuZU9Y2LudUZdn16zSmU1A2oLrw0hpIVn0GP2Ivl7/sVdep9KXQyCnHqpXFhkS
 rPH+r7T/GwtABm0RG0Z77drQ6eZEnImNoPSsr21rF4azC4kAqwmywIsvbs6yzFFUYD8p
 ko6chDyvz+XUP99E8jzx1ioUOsoVrN3YJ1CqJ4W8mr4LZ+kewKPG43k27Cu35K79yiWj
 rpoA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwM/KhF5h06oEb/+JvDpNR9elED6kq1wmG1j0D3ISxPZkNlQ48w0+7FcJFQOiW5qUP03Vef3cHdO6BV@nongnu.org
X-Gm-Message-State: AFq9FYLkuRcECddjMfMnIBpM26pZAQm4WN4QGYkrHi2j5Fj28mOYr5/g
 6uLckGhv7HuxqQjrM3UdmKuC100xJtV/52gxkNVnId/8crXpG2WaIBl0T5ZfCvuMKj44YJd0D7D
 nYXYDhjOzKbvwRCNyO1nUrQg4mZ7JG+qbOfecfP/z7uLyv8OBozfkpfupFTEZYttZPA==
X-Gm-Gg: AYBFou00Kh4932DmRIJLN1G/fDsGOFdaSkEhmGx3XFBcPSHS70cqHoqFp5Od3hRehdO
 FN8DqDsqm4lnwy4xUcJ+swsYP7A6DrIU9i6i/NhFTEMrZpHNYXsVJXjA4S7oQI+2dZX2C7mTsN7
 G3BdoTMieA61SB1z2l+jJbWHUGl5KHgfI39twjNsC/Q/DVFu3lbxwZHIydg+KabtyEj4WZnBib1
 16fNIee1PvsxbKpDX/6cDE3hycm5c32h0sPRYQVGxaDmbJ57LpCOVBS1LjyoN1Fy+jvyEDnFrMn
 bSTe7aKpnJ+OrQbBF3AP4b5nX0N3uPs/6BDybQf/ixV5C91yvlkCFlkta+ef0/nVfTPZF1Fq4uB
 ZgpE1M/mX5QFwK9zrg1FGjLm9NTuda4ArFSWS5JEDKNC61yaMJfl0ulOERCXMAgWYPclxzA==
X-Received: by 2002:a05:7301:1505:b0:34c:f181:85d7 with SMTP id
 5a478bee46e88-3537e0e5991mr87124eec.29.1791493592894; 
 Thu, 08 Oct 2026 14:06:32 -0700 (PDT)
X-Received: by 2002:a05:7301:1505:b0:34c:f181:85d7 with SMTP id
 5a478bee46e88-3537e0e5991mr87070eec.29.1791493592327; 
 Thu, 08 Oct 2026 14:06:32 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca0e64csm644376eec.10.2026.10.08.14.06.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 14:06:31 -0700 (PDT)
Message-ID: <32c3e194-ab88-4cbb-8f9e-4f19a886c604@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 14:06:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/qtest: Fix pxe-test build failure on Win32 due
 to missing memmem()
To: Eric Farman <farman@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: shentey@gmail.com, cohuck@redhat.com, mjrosato@linux.ibm.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com
References: <20261008195158.289711-1-zycai@linux.ibm.com>
 <17e9327c-efdf-48bc-85f2-64a4b334fdbd@linux.ibm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <17e9327c-efdf-48bc-85f2-64a4b334fdbd@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=E+1YNqdl c=1 sm=1 tr=0 ts=6ac805d9 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=Ty2fa9CPXzf9I1MGUngA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: G7kp7WxlNMWK6vZuObTL-rtseOsDiTnD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfX9TKauX7IiS3M
 24g07IGm1recWDSJu4VJXFOxS+eGcjDgaI2xkHiOEI0SL1vaKrfj/rt+2KfkG1AtCd6Z6NBeWdG
 BTphauyuXZYyPTwItTqO61VdfyJOUKOj7MYYqc+jVHixywqU25IDsWSlViP4b2eBjzHvgGQNtU/
 a2cGR0eLRNNLJYEY3oA7TuO0SAfqdehUGmiw7bB/E0+DYVRPUp76AvHRajVZL2mmRn2KMPF7yu1
 IRa3wpvQzyVJOrNlPPEWH8+2egKEhwvnDrxiN6xg3mlUomJJUNka9CFb1jpkihnReC+76irWqZo
 S7sCNcfYYuoXPWN6RkvtDfAwNYT1nz/qxXMdVQVEOfiWdp+elatFPgFMS6UD7stFsAfH7vt9SLV
 PmMVtvIunuPfZfq2Bunxq+NlC/BA1UtDaTZVUlqUdN6TOZKNwjUnI0HvHHh44YmwgFuE0GTaNiw
 Bs0deem3qBFK9M/MktA==
X-Proofpoint-ORIG-GUID: G7kp7WxlNMWK6vZuObTL-rtseOsDiTnD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfX1l6fPtta/n9w
 rew1V/5lFjpzJe57eTNgcybh91gp5/W4QlXKdTsBeataVXz3Yx33J+ZG+HN8Monu1Lk7ckSr3eZ
 cgHqFTPOKyNlJmgu2Zi/NiNBuZntycM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_07,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080084
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Eric,

On 10/8/2026 1:28 PM, Eric Farman wrote:
> 
> 
> On 10/8/26 3:51 PM, Zhuoying Cai wrote:
>> The s390x PXE tests use memmem() to probe the s390-ccw.img firmware
>> for device support strings before running each test. MinGW-w64 does
>> not provide memmem(), breaking the MSYS2/GCC build.
>>
>> On Win32, skip the bios scan and return true; if the feature is absent
>> the test will time out rather than skip.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> Reported-by: Bernhard Beschow <shentey@gmail.com>
>> ---
>>   tests/qtest/pxe-test.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
> 
> Either this or Yonggang Luo's series works for me...
> 
> Tested-by: Eric Farman <farman@linux.ibm.com>
>

I'm pulling Yonggang implementation, which keeps the same behavior on
all OS.

Regards,
Pierrick

