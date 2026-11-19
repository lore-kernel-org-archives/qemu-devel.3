Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C46606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 11:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Haa4NNvC;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dCHCZ/sk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU0gZ-00042u-Id; Thu, 19 Nov 2026 06:52:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xU0gV-00042N-2w
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 06:52:11 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xU0gS-0002WL-IR
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 06:52:09 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJBkBSN2331718
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 11:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6L1awVFHnc47newONQa9idSQGjI5CKhtHK/3iZ74hS0=; b=Haa4NNvCIH6TagGF
 SqzLFMd9SkBiJf+8VXJ5CcjHdjCZdanIi5psFGeZMRXqePVCsAbs5wZsDVSrBQCz
 TbIqV3H/RY8i7RPgIDkbhBP5ia6l2oJ4oH00VQMgEnr3p/zhQyCVFvn851R6qJUi
 nrQK2BSYYO3OY7vNI0V70b4HZ/X3505AOWREReVgYRPaeKdaY8ZZfeHFT9zg/JU4
 bUGIu9+dy51WoLXRSS/U9hybdCTg6C3L66EozAwbFad2jmuIqgeCwTpgxFlQzux6
 WFGWT2hH9VmcwYYJ6rfkBGQGz+Fb8vyKV+8NeSrZ5NpBGFSiS4ohofPi3gak2Xza
 BgMisA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1pdctnda-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 11:52:06 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f559420f3so256264985a.0
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 03:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795089126; x=1795693926; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6L1awVFHnc47newONQa9idSQGjI5CKhtHK/3iZ74hS0=;
 b=dCHCZ/skZArs0lanDNLDHHXR4KxKplivM4rKa0EOjSp5f2q9A7EyuJzNbk6tzACjDN
 T3BEuFVeY6a6BXJvvTgp+jaSbldf47Yvco6dw5q4Tr72Hv0CLvfnbqrz+nf8vJQNwOg+
 SCtL2fTel36jfKdbBPwOTkT8mNhXzYXZaI62SV06R+hCFjtLkrdvDoloPmDgFtcxtFvc
 zGX5XcntKPl2Z+zYcdabRMxuvv8EtqM5FRgknT0jCdZdB9kZbo32ZbcojG8sfC4ofQ2R
 SWAaGBjgPHFW+WgGRot3ixzLIk4zmbWVXABeU8cm+Qp8ruN7QlAHQPZo53SEkFYsgJcu
 J25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795089126; x=1795693926;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6L1awVFHnc47newONQa9idSQGjI5CKhtHK/3iZ74hS0=;
 b=gWq4Mtp6o53DHOYeQG+5Rvq47pOqp7jS/OKVa+trf3SrQ5wH6WC7wGKN1krbVb8Y32
 A8W24i/Db9MnJEptOGCupCFXJUaaDVclAmoxZLHGBzgqAlMQvofLqo/lI8wgT11iW298
 qKrGgOzYkAezIA+PX3Om4aANqjdQVC5CIXuahCs1LBLxGr3NsBtOFSR/0DIBclvmXkI4
 AGC6ocWZcctbcbOgDpXM9xjHfGde84TnKMASSM90TxDT/bfXk2/MzAevwI488GPrlNxc
 Tkr9sQycsk5WvP/+I//ynqUgJj8KNbQcJgnQX/itFQUYUmHV6aQsz8bU4o+HcJAEBVJe
 jP5w==
X-Forwarded-Encrypted: i=1;
 AL+hErHKcZcsPGJ9mPQoMBwM2wsUOVucMV9qPgjBD8DdCZbUX4+adr2WE9jHNA49AfLEqx5onrC8ozuemgiV@nongnu.org
X-Gm-Message-State: APuU4Z8M4WHb8CMFuoFV6bsCFOw0U1wXM1Xg3AN4COEBLuwIDMHYIMVQ
 VwpdQQnx6lEthHR85EvrktCliid1sSKpagq7i/lEfNcuWPfqMFIt3fubpx/YDcDCLdNdUrsJdWV
 GdX25OCXzZbcE94Antx/aRi3xM1woz3mxewXGTS40EesN9DNvMfvblnYv8g==
X-Gm-Gg: AYBFou0XSINKlly+GPsh32nwfmIHsC0+yMg3kzYNQ4unQMffZVEOBhEVi2iOT2859x3
 jOeDDWwjby6Tzo/IjYOfCYISob8SQNmyCQIaWeqnR9+TZJDX+nS9xVt9z7s7344VEE7KF5o6LcP
 NqUpniz5w2rUr7MDQNapmdeXXK45XD8Gw4yIL/V8I9K+qAy2CjxBKOcZBAQ9qdoAVmggUapFl6I
 HX3qiBmMpi4FpyGQmrvr3j9/BnOIqFr301NLuUnXQCHOZZHVwUgdT0Et/GHagsLovkiyzUaEx4X
 y7KptjpFBi93LOvWz+PMNWngwTcQIOKhu5lUm4abn/jnuHXANTuC7ML733a1OdxhWcbImzuukkB
 aGTPK3Gi3QxCYgoeYQ0ZfjH7Xqjmdmb9EneGFIjGf1DRbKydyL7DmutgHCgqY1oGfWMsu
X-Received: by 2002:a05:620a:710b:b0:93e:c12c:fbcd with SMTP id
 af79cd13be357-949996676d3mr1021737985a.73.1795089125981; 
 Thu, 19 Nov 2026 03:52:05 -0800 (PST)
X-Received: by 2002:a05:620a:710b:b0:93e:c12c:fbcd with SMTP id
 af79cd13be357-949996676d3mr1021735285a.73.1795089125539; 
 Thu, 19 Nov 2026 03:52:05 -0800 (PST)
Received: from [192.168.0.4] ([79.127.134.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a6573baa9fsm10936066f8f.57.2026.11.19.03.52.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 03:52:04 -0800 (PST)
Message-ID: <73a21e12-6d5c-4a81-8e7d-c7e8be8004ca@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 12:52:02 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/tcg-ops: Rename cpu_env to tcg_env
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, harshpb@linux.ibm.com
References: <20261119102319.2618086-1-rathc@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261119102319.2618086-1-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: fCp7zCgTdPGagjdRmE92mYM_GA2XwDch
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0NyBTYWx0ZWRfX2R/atYCC08MJ
 4WmRB1lcNkMKjUNRFfI9WJtWl+PIppRrpuhDZlhu13LWsAKJ7eLQvnb63hyoPqm7b+mCCqftbJD
 D+o/sEoN/31S2b54fqsmv9Arsjvb7zo=
X-Proofpoint-GUID: fCp7zCgTdPGagjdRmE92mYM_GA2XwDch
X-Authority-Analysis: v=2.4 cv=Ma/5KJ/f c=1 sm=1 tr=0 ts=6afee2e6 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=dMDxPF1GtEdq01UuaR/ERg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0NyBTYWx0ZWRfX5qJxfd29cgaN
 58/ADy++Gz43NtUjn0I1k8jyCS0h8AyPoTzWLbJ59vjupRwyxjJkv9fprII+Hn7J09jlJsYtBMF
 tkhi1zbDDszCH6pSMh8FE35arsyUhylfXilLTuF7EEgQEoydhqjoWcNWsnB3Mlb2je0XE4GPS37
 wQ5DVcWeEATnEsn8lFONtMaUpEzBdq5bJV4tfnelYZmnDfVEV9+n0wUKpoogQXZx8BD2aIg80Bo
 kgeDx+SSiYBPksFYhfc+Va4BIUFbZM0A4mpizQ2aufMO8sKmwXWN63dv2vwitS1OCp8hx0Ivpn2
 CSHVGlZpbI6OVgGhqaFlF5kt6RSIhI7Xi4cNcsQaG57i9MxFARd4t4I7v63yNX1AMEDgf9BwfGr
 84xsP58j5GL3pj/nIRcP9f8joU+xKHH6iD03OC+0ZwDRCMnCgi0Uu/ymQQrs2MD+FSMS5QuBz5c
 qMkSa5j9bvVGcQBmjCg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190047
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-19 11:23, Chinmay Rath wrote:
> Commit ad75a51e (tcg: Rename cpu_env to tcg_env) from 2023, renamed
> cpu_env to tcg_env. However the same was never done in the docs.
> Updating docs with the necessary renaming.
> 
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>   docs/devel/tcg-ops.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

