Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D4BCA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 10:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOli-00006S-Bt; Wed, 07 Oct 2026 06:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOlc-0008OC-T5
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 06:20:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOlb-0005xB-Dk
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 06:20:56 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jX7i2481359
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 10:20:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8/SurD68nXyh7KrJYWRc68g2OQirUq0Z6kIFNUFis0A=; b=VV/JXJSx1JdXmQBM
 U4O4s64/ogyU40lw7Z0j2R95CQOv0NOQWMSBtN1Jd6006o/Zi4i6KixLCf9ELX4n
 6FoU24aN3os+Vgdyfe3l6Hj2UxiF5GWEBcCaj3TkhKBH8FfNwBo7/G4Qg+EzKP6u
 L1EVDr8ZeYRFmOlqWH9lt7jVJ3WBWBy7YQO2S85RWGaOmonTagxV5HCgy4KfPaxj
 ocBJbvFZdgEewaLkTJZlq4jI0EAgGlxaVabW7H0DM7tT1LUJol269YlodaPz6sr/
 wjTtvqWbNVmaEe8x4wxiTmA9QLRBEZwdWl17PtzYOUi88PKh//I9IHU/8Y2CKoc1
 S1ys9Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5c6u1n1g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 10:20:53 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93a1de6d5c3so825649985a.3
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 03:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791368452; x=1791973252; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8/SurD68nXyh7KrJYWRc68g2OQirUq0Z6kIFNUFis0A=;
 b=AJp1yD5fwH/njqGWP55gX6MKHL8fgNWNKJpKF8AYITpE8JaszQtSsMAm9U4WKOv3O0
 jSvQNXEeXwvB1kpSB9QwFRTg0NB0CnxSB1cR2Gns3yQJq7fLGc18y+ZvvLTK+QxREDfk
 FiSh9uQcwwkuLdjxsDtD+S/wcSls0lRCcZ9UbXom9WMfweeFhw2NhcdbPyIEAiDJXKPE
 PTI6lJRvyjaD+pucjkY0MUYvNnwijAzjrvEvxDjD+QZOAlRrDPjWVsDwkqUDsR2MZWiO
 51s8r22bgJ9gzAoE9Cu7hDvwkgtQ+gZjXlfxz1ipcM0/7b9jfT+aHtNgWJddjo+PvjT+
 liXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791368452; x=1791973252;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8/SurD68nXyh7KrJYWRc68g2OQirUq0Z6kIFNUFis0A=;
 b=NEadlIEOS1OQCFn0Zw64ktHRMBsrU+Xki0x93Sme0fy6CmZ/cU1gzr2qHZY6zIUclP
 vWpYBiFrYquzBoaVjve6jJRlpv4pVvv2aMfEI1lbm9Jw0YBIHWxttA8Zw5PrfnrecRnt
 fbAhU3QhdokqOeOxNN4e2uLUK10RD4cbVcu/no8cnwzqQeWStfOTlCKXaNEPaRghSsdS
 LIP1IoMdD7PnbvXOsV5YyaOvVDQ0/gM4myawb05Lucsi6lTLIhPbDMNQGk5HAr7Xort3
 R1F/nygd279hjlHTZaRXIOJQ6U3reXtY3UptvBXSPwoebQfcvYHDUR7s8DqUC41ojjoE
 t2Hg==
X-Forwarded-Encrypted: i=1;
 AKwUvByAXPPsQLrU9+KLNgmg/wWWeD4jCOrod/lrJvLysNM1ZHlFDu2DXQw01Inh4c90pAj+PP1bkLQWrr2z@nongnu.org
X-Gm-Message-State: AFuF++k4t8YjR5KLd/YqvgW07U9QnpIH37DTRYErjH+L+iQHgju3DLmT
 IC1TWYMdrLkVunm3b8jhHa74mECkKYbaG8MVaaUv2SBzHR8SjxKtPn7BqerlIsUTgN9Z+Df1s0X
 eDg/iysslvPG3uCjNXMgUmVoSGDJns3dVAjeYFPkVqQj5sLra7HtpwCdFJw==
X-Gm-Gg: AYBFou0SPseZHfq+JFK53CCdsak7tCiOOx580F/tM+qsV/FJv72WmsPaxchJo6yHE1i
 82aV+KJvvgzLmt+3hrXRlHPOkxWZWVDnKl9zNX0eBVk0huQ2oD/W9MC2+VMXPwom60rj21EBicw
 XY0RoM/FBiwMQMjGjh3v8K90sXX0B0XjeQ4x5Ur7jrU8yBy9h2G9DGNZRnlghEhALy6mSXCA8S3
 Outokl+u2sa8DRliMnOHm3uy5+V+USZpO/iAaxrkexa+E4tqzTP9nOqcaW7bkoCpZX3wAIGSpko
 q0HvVj4JkjgTXHWNVuEC+Fgu2ayKwRHn+xZSA6g016OrwH4CWSYwEVaYmUTI6G44Qafa11FpCBk
 F9zm7FSmcbG1RUG0dcHchS5HKkCxIUHMSNA==
X-Received: by 2002:a05:620a:46a3:b0:93e:9809:279 with SMTP id
 af79cd13be357-93e9b8a0f93mr303838885a.81.1791368452215; 
 Wed, 07 Oct 2026 03:20:52 -0700 (PDT)
X-Received: by 2002:a05:620a:46a3:b0:93e:9809:279 with SMTP id
 af79cd13be357-93e9b8a0f93mr303835885a.81.1791368451638; 
 Wed, 07 Oct 2026 03:20:51 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f54a650sm56001075e9.4.2026.10.07.03.20.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 03:20:50 -0700 (PDT)
Message-ID: <f1f216e1-9faa-4b9f-b704-0a33ec0f34d3@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 12:20:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/18] target/riscv: Stub KVM functions for
 machines.c/cpu.c
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, luoyonggang@gmail.com
References: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
 <20261007-rv-dedup-v2-9-8a2f0f296a7f@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261007-rv-dedup-v2-9-8a2f0f296a7f@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0MSBTYWx0ZWRfX0N+ehrR15j8j
 Dj0FHG3N0yVmX0faZBN8NgwYDfOJoxAOA5Lq44sLEHRo5Kcuzqki54zSrBHdw3Ibxy3+oIrfUb4
 u2lUSn0tFjCWYgOXb16RFNgn0qZZj6o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0MSBTYWx0ZWRfX6eca6bfdgWZB
 /lIDy1Zoa+vtwn6VBRPVChqytOmna55XGWvunSqV9B8IdmMOJiXpfyU1X2r93Kso+bJDXmlOm+D
 v9e+jokorwQIKzLDHmNKJN57eWHuFQZCPejnfxhq6Q0csp8k/R9mPYW+zcNyiWYnNwq4roxjKMu
 h5na9li2/Je2xs6n0xqg/A84K1i7YmkpsZvsNlRSGAooQyA0qreZcIHH9Xj/NLdrSNxUrG0+t8Y
 JO9xjl1BcgKqoS3apfSIyGKoOczv2uZKpA2YmobDMb0oQb1W1y1qqcVZaf7YBJIhCXpRovY2MOs
 nJwV1DgxYxHD+TfoVCe1vm3WdjJ0RcqmHoUb8Uaml/9SYVzyNRWbSqZY2S3TzcO+OSNbsiwsM2i
 t91t2foOBY1le7PMv61q06aMD3Pp16TQBfmKqAQFoO6NXQfslpV75yQWOZCkIXch/ZhdBi2pmIl
 zR0fhEAb3f6YqtsStng==
X-Proofpoint-ORIG-GUID: UzZJO_Zt6ys2LHPggl16eeqk7FKi6f_t
X-Authority-Analysis: v=2.4 cv=T5EZ3PKQ c=1 sm=1 tr=0 ts=6ac61d05 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: UzZJO_Zt6ys2LHPggl16eeqk7FKi6f_t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070041
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 7/10/26 10:43, Anton Johansson wrote:
> In order to compile cpu.c and machine.c once for system mode and keep
> the linker happy in a single binary setting, we need to stub out some
> required functions otherwise only available under CONFIG_KVM.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/kvm/kvm-stub.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

