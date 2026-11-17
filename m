Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7D0606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 22:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Kks7Cnyq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=K0lPicbR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTRMf-0005Yv-8F; Tue, 17 Nov 2026 17:09:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xTRMX-0005Yb-HK
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 17:09:14 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xTRMV-0000yI-QA
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 17:09:13 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHKf2hT1237305
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 22:09:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 x6aVcnTOQLvXlJ5ftxwe8GaeLpyg/6oo4ThGfVikkEc=; b=Kks7CnyqD5WyJfZQ
 3m1oJuva7wiMlDj5nglL0lrpD+MP5lqTXtoNvnQAuzKmWdDbSKqj3FH1beVgWbFO
 KvC8RmeRnxmT8YcD+Q/5kCLNp9SfprEP/ztZ3y/TIBeZ7z3gtvDJarcAm4dqm//P
 KSV91WJHzuFKlp2gOBVhwnj0KivbwUZ4/sk/tIQ9zu1Ko8opmBsMhh+BCmg5D3ha
 X23Zd4WZQyfztwyim9psYFpuDx70B39WUklZHifkiMqBH0g7+PN0TyjWSvw+a6XJ
 omHiE1HxFZnbzrQU2d1xNjND3iRE5FS17HjxkseXVtwq/uP7Y/pLeXuHn6JtrhJ8
 7fJB2A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0w58rh7m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 22:09:09 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f26dd2165so97267085a.3
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 14:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794953349; x=1795558149; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=x6aVcnTOQLvXlJ5ftxwe8GaeLpyg/6oo4ThGfVikkEc=;
 b=K0lPicbRcXGxXj0QbUt6hMm0k+1lusFopa4LsmW+fMBmhWCQ2CNuUI8B4ZDGQEKzQi
 XP4g/vmidBP+qo1LhORaptxnnvUFLmxQVmjZuVGSBw+oBycEIJd8ugKS7uTGzFvWUwTM
 oBRJdwqccxV+7PLTxtPYBapJEV5YwPJqgP9/vX3AoFeZnv8BziwAvz+A1sHzyRe5Nqzz
 LfrOeCJJ/nDR3QVaheZBJJgi+5vl2DlWrWBcgD3O7vud/qT4R5skXpIhYb0pYfcgsdXn
 HeCL+wRdAeTM5Pq7GgnWjxL5xTlEvAvcoiDtKqiz+P2B2Y2d1vCC/BUm66FUnUzAkg3S
 ktgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794953349; x=1795558149;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x6aVcnTOQLvXlJ5ftxwe8GaeLpyg/6oo4ThGfVikkEc=;
 b=nnUpIKxSJCLkXgaff/VkZK3PYaTU8VVmYBEyMoq2kUgtKlZkUTtktGI8FseyOND7kQ
 8PhmL6vURCOp8KqgF1bhCHMSU/TOANaKNxfp+AULUj3Ql95W5mftpkBFAwZ7eTShzlhj
 uVjGFfnIKz2gKn4ArYV6GITE4F/C9QOEoR0gdPqUikNzHk87gKRy8ZMCZiK1EG+nP652
 AuhdtzZckyWRgdm1xmns5mWWIQyzDJhE/zHSm4tCyPnnU9gMomCq7cV5Xk3PGUQUjhcC
 pxPp/C3/Yq7KKL25/uIodFyXBeCDbzueP86QeNyAL/hRUMKEdWc1bjVztmVWHI50dRcr
 eiAg==
X-Forwarded-Encrypted: i=1;
 AL+hErFPaTMJLQcBvtrVYSR0CSciw0kwe6tEkUfChSQWHXN32WeHfhBMta4QdVen2xbRc4QXMh2XQydbSCP+@nongnu.org
X-Gm-Message-State: APuU4Z8e5xlzbFNhLhoKoNGZ2zJOkx2STSQxFzyBGMRotJQD4OFluRCG
 pIJsLieb3NbRMRwx30eRCmGFKXA3UlOQMl8+QqgNtzuy9qT7mMXIZSYqAjl/1oY26QsTRtkExC9
 7qPeWg9p9fmFms8AWSkISFu+Lq4o96l+U/bixL3MM/VbSWaug9AJH9hEshA==
X-Gm-Gg: AYBFou0jf5O8WLl3OdMOmSrKMrHYDwzVgqnlYu1+6BlizYn09v0JXHtaZJAhKYxjr4J
 BpkPkDKKnXywobyr7ep2HN20grBrSnq3XHQR4lxTd3dplO9hr0pvrCCoaBnY0BkkvxUfKCrKzeh
 j2NnSIh01o4v2qvzoFtIdm2ZaBLqBhs2kv6zWDW0H1JbIZ2ASukGmKpSr3/3C4jnhO1Eb3cOWvJ
 h7Ss3LwbqOLnI8k4/y7kLV3VTy9XiaCOT7UoKnFQ2cBkMESTivCPTco9NC2OY9rJNTdC+hn3lk2
 BBrBmZs/Dj9btCqn1ZNwDu3W/uGDuQ2fJTg01jQ7fnZCo0/XEZ7JQ676XHshAy/1FOoCfalt94P
 4l2mcCCEP8EpqsNXw3v/DpcYFBDT1341lQ/XEwmkOpPeXK8LZKsAgvubR3nmnVlKb0SjIqpTm30
 BsSi4mJik=
X-Received: by 2002:a05:620a:6508:b0:949:6b50:417e with SMTP id
 af79cd13be357-9499957e713mr181893085a.27.1794953349344; 
 Tue, 17 Nov 2026 14:09:09 -0800 (PST)
X-Received: by 2002:a05:620a:6508:b0:949:6b50:417e with SMTP id
 af79cd13be357-9499957e713mr181888885a.27.1794953348872; 
 Tue, 17 Nov 2026 14:09:08 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a6573bccb0sm983279f8f.55.2026.11.17.14.09.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 14:09:07 -0800 (PST)
Message-ID: <e9d89a36-a536-4853-ba62-28f80ae56f5e@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 23:09:04 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, Kevin Wolf <kwolf@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260930085433.830743-1-pbonzini@redhat.com>
 <20260930085433.830743-2-pbonzini@redhat.com> <avy4mkin-orpwskO@redhat.com>
 <avzDYfG-cPiWaCZ6@redhat.com>
 <740c20c7-f8c2-bcb5-4669-d996a8a90cda@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <740c20c7-f8c2-bcb5-4669-d996a8a90cda@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA4OCBTYWx0ZWRfX02NNtOecDYr4
 v7C/C2g2LQHKXehVroBAGLDgS+cnVSWOvCTlR7sx2d4orTPdveVe0ybJurL6uY3Q9doTNoLnAz/
 sU3zgnlvFkeXgKGwvwqx1UdM/37dmUbFFaFhBM34qaLBIyPwcAoMzMKcxWDGQyGV44ZKCrL7eX1
 mr0yRfnONKVnUlg4lxG0Dhmj+gWp20/7tXFVnk/fnbvb9d3QupbCAz3h7GxVILaua/aFWfWKst4
 MphKPVgEeTuTVu+ZuisXzdKxd0N/D14q/Gw3sNWTfOZcDtStdC8qGl6NYLCA2T/lhGfjDnFiN81
 CtpYSGZM6cosv5Rsft4eJDT+9xDc1JmE0AoaA2fMnAc68UOn7Q+3Vf/bk0ypfo0bWJn+zV/jfgX
 JkFs1dB1CtLA3EZFPP1ls6jcUFj9UHH/RJLumV084E/FeUAqnb0pHSgPYFiE4yXJgcY05REGxmD
 huCoctNQU7Oe2Y0TTRw==
X-Proofpoint-ORIG-GUID: 3xP5KH2ViypR5myaibKHPZUberdl-g3W
X-Proofpoint-GUID: 3xP5KH2ViypR5myaibKHPZUberdl-g3W
X-Authority-Analysis: v=2.4 cv=fIqsTpae c=1 sm=1 tr=0 ts=6afcd085 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=2hzWjV6PSdohnH0_1ZcA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA4OCBTYWx0ZWRfXyBJeytazrt6X
 VPDEkhNYX+8eGRCtCWvhGKYpVJCm5gVDOM7dcXukmfkZI5ivcCA/rMvI31N5hFn+2eiu44+BuYh
 H2SBDZiDt+I7mQFDgiX0/p4kCVZKZ/M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170088
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 17/11/26 22:42, BALATON Zoltan wrote:

> The problem is not people using AI but people using AI who otherwise 
> have no idea what they are doing and send the slop unreviewed and 
> untested (or submit tickets that way)

I'd rather blame AI-induced automation bias which also happens to
"people who have idea of what they are doing".


