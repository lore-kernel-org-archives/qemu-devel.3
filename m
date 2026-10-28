Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676E6606A33A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hKxt8eYi;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TnlRkCC5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM9vj-0003ns-ME; Wed, 28 Oct 2026 16:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xM9vg-0003nQ-Ox
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:07:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xM9vU-0001S8-Aw
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:07:13 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SIPq781395713
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 20:07:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ucSRWF12lnGJyZN7+noEh7KsB+kwIvYgDfypgnlLxe0=; b=hKxt8eYi5uSYGR+N
 xQjpnIo3AJpd7O/7jZXZyxIyip/6hkfYz6EDWwQChE9aVXl0dLpnOIOAOd8NIWCb
 1zudHNnJGftSsn+7qyUWTegW0trY5+H+efWiClu5koYhdxufD3VKjyX7KeFMxMY5
 boHUSNz4ewhsVeTo9amq1E3VHc+sdmnR1qdl+Ni7GTQEE6EamGq6+DL5gmVJvLWz
 QhekIdpVpTjyG2KXEmPrDjnyO2Rl2cm09Cy9eH4mAQ/gTnEZ3JZ1hVl+BxRiO3J4
 +qj2c1RKZgEasofYfqbb+UGl8N0T7DFmmnQqRLZWYKOvEMHSSE1izeEJZfi1mN1k
 xR8EFA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkhtjhsmv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 20:07:10 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3425098ae4bso84536eec.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793218030; x=1793822830; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ucSRWF12lnGJyZN7+noEh7KsB+kwIvYgDfypgnlLxe0=;
 b=TnlRkCC5ywI7g0AzwNDgqkBHgRFZKvwXfZ42IydYv5HGPc6f9NmiqteprPf9kXZYPp
 FBcWpLypLJ67w2DDeJhIhnCQNUrz7NBn/e8VwHNXodtyraBpVVVsrg6l2HZ5W2tkdLrt
 J8JOmB0TarmW2gxQoz/Ym4SDuapISH1X3VAwrfPClaB+xUEawEado/jcI2/N/odDabGZ
 759zSaShDpHB6nj5IOjHdqrZi6ks+DwDJS0j9VilmR39JtykGiMpG1rXhBmNjuPyot06
 Cg3h5GC5MOdgQoUzbZiiryMZju0nYwFHsoPusMCO2WMm7eZK9V2PGNdvcTP3eMGX+H/e
 hDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793218030; x=1793822830;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ucSRWF12lnGJyZN7+noEh7KsB+kwIvYgDfypgnlLxe0=;
 b=IxDDSGz9ay1QwP/+NfgPhefHgpE5mYv9qPxPJRznNdhC8OK1fkoMDkhX6amEvsf/UF
 43EkcXK0J52anfnOCjVVJngZKy+4A3Cg8R8i7ly4ni88U9e/2rk25jb4ewhWT151221i
 wgzDblO+WDHmDEHCJDwomQOj51DqkEGro9on4SoQ8U916csyqN30DdvSrNkZORzIe/FR
 28P8s+EOPFn6H2fFym8Wx2ZYzunMlg8ZuhrAqsxWWqq8c4+wLSduNrf/byau12g6PERV
 rwr1aYEDjwq/pRuj2VPRdZlvF6Ja+CCvYx9OQxtUiT0T45hjRQjNGEPWgxLPsoO9uXJY
 14ng==
X-Forwarded-Encrypted: i=1;
 AKwUvBzbNe8k85FzlcJStwFHRLwNY3AAqpKPAskquYb/uVy4D3cfRT+hRVQ0rhroUfpOIRvliLM02bI9ArEI@nongnu.org
X-Gm-Message-State: AFq9FYKzrxnHPC8NA0HVnF/utmCOQVFS4pRMMekOo4oD2U9Z9DO+JMDd
 M6m7I+oL4DJUBBflV9TvwAx8TA5S24NLKmscHcUqz7dljjNtslIGslpzlkdWBacAlP3+6g1m/2n
 +bvHfRFSeDKlKqomPMGcyOjCfc38FiveGXyhp9YDOn1aNHLxBFubTQo3Itw==
X-Gm-Gg: AYBFou1ZzXC2Dwzkz3uJHRLuFzQfAlYod4wuHURQychsVQQU0PXSL26UYHBMfjXrkpA
 yJlVlE5qckuU6/jXlQXRwWS2SzAjQVGJJYtzz2p7/u9FzCydebBmO+ce88QP5nje5wbRemXlXll
 Wl15cKCiAR9XTMNh/AYCuDosgK4hQPobx56FDXaXwU8oLpq78M6G7IR0VqjSR1SA2/mDicmcLv6
 FFgMxwVXQzz0bOK1Sw17cGLBJ4tXyjq3y3JpgweQQqD98Ck5UUccQj+2MqHGkv50nlMVzNCRTdk
 CO734p/HOQ8UggFrJhdfTdsvomkrId4D6U5wUj9M9QgjToIOccoWfn7cOL6xy3BrAeCgy7voUhM
 sK6T6kbQr8ZlP0s0CgzQrUeOf6+OsVEJbGaV+InNW28Zk7CqVdF/YINDv91/iYQDsSScLX0P51W
 m8Iq8UuX/DUzsT9dZ+JVIaUfx6h+yL5qD/4EBiVHi+UQA=
X-Received: by 2002:a05:7022:42b:b0:19e:3464:ce40 with SMTP id
 a92af1059eb24-1a941feb674mr781697c88.1.1793218029483; 
 Wed, 28 Oct 2026 13:07:09 -0700 (PDT)
X-Received: by 2002:a05:7022:42b:b0:19e:3464:ce40 with SMTP id
 a92af1059eb24-1a941feb674mr781648c88.1.1793218028791; 
 Wed, 28 Oct 2026 13:07:08 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a75ffac4a1sm7716970c88.20.2026.10.28.13.07.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 13:07:08 -0700 (PDT)
Message-ID: <057696cb-8206-4d9c-8dae-41c39df6fdfb@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 12:07:07 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] tests/tcg: Massage MIPS tests for easier maintenance
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20261028192124.30941-1-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261028192124.30941-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA4MCBTYWx0ZWRfX9KAZO9WDAKiN
 Tq/EcFnhUH6eO2xXTgCyUOddnUG8ApP3bUBV+mZI0EnAgw8rc7pAuMTSCwuOF8HSzaxEysPWOp9
 99M4MIzEY2tmC99Cu1WwDRTNvu97ah/Ea47NhvLJckng7iz+IYBsqYOS4mQY3otGX8B6oElmXFf
 45UF1TcZKjV10pPaGFQHesnIE8hRMkP/ytVu77ElFfWZKJ5Dkj+ZZthDRyXBOi8uk9hWfclsqDD
 U/4Cp5m6eu0gf92fl0zIkASFVTR0lakVzyza31+FvMmSXiOa9glLgEJVnZMOmTt/cHhHdq4SZ3T
 7yh06QYlT2L9co1l9dEvj9MFXrwFolm+l4Kc1xvJFGp7rU2cTVMdz7Iz3NaeSK/mkv4OePhLcuE
 kVHm+0/m6F4TicQiedf0ieP7hgzxiZbfeCvNjKYdCDUEdPC2ReMqU/eHCcnRqr2zShARnilmBiv
 2nugXvsQNUNzE7uT/Wg==
X-Proofpoint-GUID: 0rCiSuXyXrxZHNo8oXzFQC5Lk9T4-cX5
X-Proofpoint-ORIG-GUID: 0rCiSuXyXrxZHNo8oXzFQC5Lk9T4-cX5
X-Authority-Analysis: v=2.4 cv=LdipeTfi c=1 sm=1 tr=0 ts=6ae255ee cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=ttNbwzGGGyJx_nAWgVkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA4MCBTYWx0ZWRfX2Ga/jKqsxxbt
 TwZpZOPp7NkJrjlDzcItsyhKGPskGIJKZmaivaJmKO0Gry4iQ5xnv3Gt4PKhcmNLRY2tcPmdCoY
 Y+D86WJwFwG7K9m7V9xfo08j1P758LQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280080
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

On 10/28/2026 11:21 AM, Philippe Mathieu-Daudé wrote:
> I'm glad we have many MIPS tests but they are in too
> many files, taking time to get compiled. In particular
> on Aarch64 host via x86_64 docker image... Group the
> test in order to reduce CI build time.
> 
> Philippe Mathieu-Daudé (4):
>   tests/tcg/mips: Clear DSPControl at start of DSP tests
>   tests/tcg/mips: Group DSP tests
>   tests/tcg/mips: Group Release 6 tests
>   tests/tcg/mips: Group MSA tests
>

That's a good idea in itself, but this would need additional work to
have a clear report per test. We can't trade usability for faster
compilation.

Right now, a test will stop on the first assert() met, without going
further.

Ideally, we can keep the list of tests in a static table, and perform
the DSPControl clear before each, so patch 1 can be removed. Also,
assert could be replaced with a proper return and print information per
test.

Regards,
Pierrick

