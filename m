Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B8C606A337
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 16:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lsBeWo1s;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YYTV+2Yo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVXIB-0002ZY-Cn; Mon, 23 Nov 2026 11:53:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xVXIA-0002ZP-Dn
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 11:53:22 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xVXI7-0000zc-A7
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 11:53:21 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANGHvqx236065
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 16:53:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fIemNzDPItYZMgNIDl2/h8UmLtcJitae4djsrRTai0M=; b=lsBeWo1sk9Zp6ZaE
 p6IyVjvsYRnLkPEoS+3hRkWhLRfxK/Tu/EhQfht4A0IPkBR8v5f07zgsaswZcCyk
 LbMbCSKqAUOujKIo9nDOhrIfdfknTbVt5jtY730dFdx/1ImoWko0FaZAFbGxehCX
 KGez9IpbOvpoamlQxYOn8JYFhu06009stNNt+Y4hxBvJXunwkiOWShUf+RY2IS/G
 Xepf25XrfOuXmgRQ+HvHyi7ONt27aOIefYi3nWIBoDiSPJaQOww/sWz8Qiva8RJ0
 +KYxRtt57HiSR6WOWNKzpMWoSXwk8ihtWZ+AAi9+O6BzZhC4yZfq23/mbR0tY96U
 R4RIWQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4evsjmyh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 16:53:17 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3b4139b7abcso3294066a91.3
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 08:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795452796; x=1796057596; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fIemNzDPItYZMgNIDl2/h8UmLtcJitae4djsrRTai0M=;
 b=YYTV+2Yo19IhYh8oEsaTH0MiV1gzTwO7spOiJdCVb0VcBcPCD32hXJbeEK9P8SC72A
 9I2HKD+vvmH3jhPTXmbFTh5BqAtW9NeXrIus1NfLdZyL4pfGA+1PvXeKkXoxgXOnJV7p
 LtIFcsXbdKEqYmj5YEVQjuWcfbfmP6/D2rj4T6dRc815mTzOyizB3a8ZXBw/2k+7kEgl
 BdL7s1tGpD4rdBF3CpfADTioaawgxHNKnbQVXHGTM9KVTf9TqsrbHRDLoIF8N+xjpEEw
 +IKvlMfgrM6eQPCL0M2Ez+T7eHvQjNZtP96TSIJfLZFqS8eT0cZo/I1nlgbocRCQP38u
 /vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795452796; x=1796057596;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fIemNzDPItYZMgNIDl2/h8UmLtcJitae4djsrRTai0M=;
 b=E0noqjBLRWgvP0g93cICjPi2ltzN384wyCduVvXl8XIJMyp3gV+x4AKvCfzMzus+4T
 PP8RIxzhSdVp9ce9JAu/R7ejq1zGJVfEWGh8PumRG7bAciPDoZewCm6dVFnurAZXA5dn
 r9jondqYzmHy4jX3ut7Xi/AJhb/3bwgU+67V1sNDnRhaHxI7OvRgF6BPkVNpgHkKPuuq
 TuJoIoEih9eNCmwc024lLd70GGTW57pNLCRIMgysOjtIcoamRkwp6Do9svpjiEiIkQzR
 Leb8S7T9E4W4MNfAjC/v93DwD2V3LR9k5n0Lv/qKjvg9gb3EyLLamHwoGp6qsgT7kkcQ
 gR+Q==
X-Forwarded-Encrypted: i=1;
 AL+hErHqzHCRDWUP7gPnjIzpIHaYhtLnImCQhTZtn3tVHEW9Xz5HwxHVn7jGpgzgtwBaK6aW5hhG83m8NwII@nongnu.org
X-Gm-Message-State: APuU4Z/lreh4+oUO/jkz473Lpn2D9mEfuIHy+gItjFvcl9W3vQSas3Xh
 8F9D9e70Sc6LuSehqJRvFZBX6klBtdhSWtPUdO2hmOcko9X+0ySxhruj78Y+wlkEyVAF0FLS9mK
 ztgCAT3PJIoorMbhmulCAy96F/nJQpY3ZFkCSkPoORaqphCeOHVIMqhHasQ==
X-Gm-Gg: AZFdTZfDmxFw/GZwaAzWKSxKtcKFW1yjbj1Z9ls19bm/tJhgo9bC4my/J4ANb/gdDqb
 /PamCwR26xZsaQgUHZpxL70pfnllGLLL/iLjgDE2OO8ygQakSDCLxz+Lt19eNCly0ELDy8ouRaf
 EfprVM7/tLWfKndMabO6ypkry6wGorttSUDps2nDLZk7/7WJ41CK284WsIZMSGz8bd7EYwyS2I8
 ypJ2ViSpeDxVNXt+LNhaYhYOu41fd9wPMNzDmNErmd8Lst8oh5r21ogkM1h4qu7k3Gnim2HawAL
 GEx+mRFfTdpfjGxz/zIGn0TANzBsUq7nC54efmdIkHCv1dHcp9X2gkw/Aa9Fvw5GC5nYYhPzjpR
 5TZLASG/PIsDU0KjFE8C+s+s1KcLwFzh1DSxUiAeCOqG0+zrzGKFb1PfU6Shgt4s5/KexK32XKr
 N6k43wTT+cQEx4eL+ErahEDiKJ4wj4nbBOFeCx0VG3m1A=
X-Received: by 2002:a17:90b:4ec5:b0:3ac:7e3a:1033 with SMTP id
 98e67ed59e1d1-3b41c96182bmr11048520a91.59.1795452791385; 
 Mon, 23 Nov 2026 08:53:11 -0800 (PST)
X-Received: by 2002:a17:90b:4ec5:b0:3ac:7e3a:1033 with SMTP id
 98e67ed59e1d1-3b41c96182bmr11048492a91.59.1795452790869; 
 Mon, 23 Nov 2026 08:53:10 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b405ecb486sm21403505a91.16.2026.11.23.08.53.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 08:53:10 -0800 (PST)
Message-ID: <cab815f5-0c40-4313-bbd3-b7fea3beb92b@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 08:53:10 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitlab-ci: Switch the msys2 job to use ucrt
To: Thomas Huth <thuth@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Stefan Weil <sw@weilnetz.de>,
 qemu-devel@nongnu.org
References: <20261123131427.209394-1-thuth@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261123131427.209394-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AL9GXjHq c=1 sm=1 tr=0 ts=6b046f7d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=MrylxDkSAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=IWvpCMiW1b7vhsy6DWQA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=ZWqyT8odc8aVHPXL_V4W:22
X-Proofpoint-ORIG-GUID: lOj_nX6mJx7bBf3dUMVvpFL5oDseDD6z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA2NyBTYWx0ZWRfXz3qaOhTi+8pj
 S7oM5Xts65QKR/hfB91BoARQeHDB2ocn3LsOxVr+//IkrMEu6oFl2aI9icxHcw68hPU3beHgLeC
 iU6gYJRdgcA8K95zXUmE4BUoxLmNhhGijMSYlGKvOfpedQdXjfJhUqQa+HhnteSbF9JIWeSiW19
 ONoqstBLyYbs8kS41ZzZ5xk4rFpCoG9sbm/emrXu4P30DFeAwuRVSYHggVjtW7szdleGHmEzxKg
 dut2txaDLGOPZkY1SdKsGe14MzSce8YFG4Qwi7jpjGEIi+u1Bf/oTynS2K+2Tq9j8GXtDNPorS4
 rmMZwIcmf932JBJICL/SaNPcz7mGh7Lus6sbrKKu3bjTxBTAHJ7xUSEftljhKfInpi38R8sVcdD
 Vh2m5NLcrTAu2TG7eb8H9+qTD0t4YI2x5SnZekkh3RvTL0HxPusleFOvcGfhEOXj7PbELewiWr+
 J2H2E4E05MjoB26vwYw==
X-Proofpoint-GUID: lOj_nX6mJx7bBf3dUMVvpFL5oDseDD6z
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA2NyBTYWx0ZWRfX3OOP5+6dsHq2
 pcPAVwHayyjebJ2W3CLj52pSWpHUL4V+vCvfNxK+7Y//cSO4VEME0QDLc/JXaCC4lGKQqTRySSI
 ZOHWKD6pN4Cuq31/w6qZX5yJcyRxul4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230067
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/23/2026 5:14 AM, Thomas Huth wrote:
> The MSYS2 folks marked the MINGW64 environment as deprecated a while ago:
> 
>  https://www.msys2.org/news/#2026-03-15-deprecating-the-mingw64-environment
> 
> Now they also removed the mingw-w64-x86_64-libnfs package, so the msys2 job
> is currently failing. It's expected that other MINGW64 packages will be
> removed in the near future, so switch to the UCRT64 environment now instead
> to fix the issue in a future-proof way.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  .gitlab-ci.d/windows.yml | 39 +++++++++++++++++++--------------------
>  1 file changed, 19 insertions(+), 20 deletions(-)
> 

Thanks for the analysis and quick fix.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

