Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8C3CA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 18:47:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDniS-0005SC-43; Mon, 05 Oct 2026 14:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xDni4-0005Ox-KR
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:46:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xDni1-0004vK-CT
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:46:48 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HKkRA3532924
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 18:46:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 74axeuIZV5p7LQFAr2MQRPRvLDolCBeltln29pWx/90=; b=V4P1CkhfC0XbrL+g
 Tt8hvgioJvb9TawnZ44Q1JyIkWz2By6FDtm6ZDAEml5KaVs2bBbwmH6JdSVKMFeg
 +9MZs0jwAikTRDXUZoPtSVjL/O5dILjGQwqPa6HYr85ytoMxgF3qRdBkq90et4NA
 yWQhKJRiZAyGVZDTCtUsXn03n2JCyw5jNwi0w0LkqjUlUEPBy5GZi7hG4lDbqLOF
 RRGK8iIdO7tSlNLtfdGyVYmOlEDdRulW1vMDHWgXe86SaY1W4kfP7igfwJ93PVe8
 jCOEtmYpRrNaOdp8Dhe1VgNeCTidW8WN7O54Ng+BBtDvo/4/C0rBzptfPzvC1VhY
 fPEBKQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h49u420hu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 18:46:38 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cc40759b2so428206585a.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 11:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791225997; x=1791830797; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=74axeuIZV5p7LQFAr2MQRPRvLDolCBeltln29pWx/90=;
 b=BJtRNyykgH9qfbfTWZYufBGl/BvDNdKxIEDT5THVTdNixer1xep7CM+cSBGW1HI9Tu
 hELJoySxUJjhOECKJOf5ckuwQwsXirwWDJsKNoEgk9hxZwl9uw7wx8MxKMHC4X4Q1wD9
 8HAS7+Ek29HQYqfJag8z5AzmhrIRX6gPgjLbTprhRVJCfkeY0nUWQdLql2XKIUAK1s56
 fzXtXTPwFMoNW1AIUKmGss2oSJDa6f879uLk95ICr4Q6yvBs1bWlOKqrsx8n0xnzV61j
 NHMXGOv44Sw9FSw69cYAjyHnHeU18UYdROHFM8ZKmeXdKp71h684MnQdHEGtVlp6D16N
 RExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791225997; x=1791830797;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=74axeuIZV5p7LQFAr2MQRPRvLDolCBeltln29pWx/90=;
 b=h4w1NKhNXT0n2CcDst08Q7vnicLJ+VmsLEczzMbbd2FpuGbyfWfeF4zsZuk12Obfb0
 USC6hCU/VAA7B+Mgqub2g8OR62UhVNiv341TlR1OKMizbs6JqDFmKECMRTv26oPSoxYW
 vyxvzJgnVT+GXs0bZVOz1IaWpKQntdRi7rA6Ei3cOmKjN+WfONpZgtM6qsNugkubiR98
 zs6UbJDzSoxwz/tpkwrlZ7Aojl7L2Wk+HGedHzkEJuOn1dWK4tMJg5FHUS68FsZukuHr
 7nBtROMz16sP2MjIZa4S66YjsD0QEoxHHiWZqvcvElXSvVfj8Mmx1BC4UINKekyhlbIt
 h71w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzyXwemePLpQoStupgsbQzV/hMmgXXxRXs1qgPJI/IwT4DbA5G9kE3+tSwWRPu56BNOxfcwln3TKQGa@nongnu.org
X-Gm-Message-State: AFuF++k94GXR5G08sCkF+99mfDR0EqDV3qf8VIykb7gpWH2LKU/kOQTe
 5QtyVIEeBeyOmncf1zx70pYSA1z6BS2XUqfzG0dGof7LR5B/01eIvlQqaYhfSWW7sn3B8difU/S
 Fx74kKtrgU0e+VntDpgZqkSjEhvv11YrUTzPLKaWsFnMlBxEY/QbnGh2EgA==
X-Gm-Gg: AYBFou0ZuLAcJow3REs4Iu+s1yF577a8McPYxNxv3Qe2VeG3NjcZfINZxTg6T2Y7I38
 3qOySpPteEC0PliJ5iW3s8/itbNgfWK5MmBOy25CPuBW8TKYnPUOBlwe4ZsADHqz2W8VRdVA5hF
 15MOyUaxE+XRhYiiVTquJFXYS3Jf0VUSAyXDbd6CXFyw+SUuPEpaEVNxQMJ9mQhvSm1bsjlxCVv
 wVriHCkzArVXeSQE+K9HiIO8Y65+8z7Z7pBhbiTJISl2kKlzcGPVaEFcd3GJUenIZ3CXgS1UQ7J
 yv0IEQsHP2QUXMxikRyCb2MFpfJNpeBdsPVnDaxGFzpillnIVGODouSwF0pWAvPnBxzVcN7+3ob
 9zAk6OW7CqjEOu/Ib7onykrxQdRqCj8J0kQ==
X-Received: by 2002:a05:620a:890b:b0:93e:6b9e:6167 with SMTP id
 af79cd13be357-93e6b9e6f5dmr845167185a.16.1791225997004; 
 Mon, 05 Oct 2026 11:46:37 -0700 (PDT)
X-Received: by 2002:a05:620a:890b:b0:93e:6b9e:6167 with SMTP id
 af79cd13be357-93e6b9e6f5dmr845162085a.16.1791225996453; 
 Mon, 05 Oct 2026 11:46:36 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1787e7792sm11231435e9.0.2026.10.05.11.46.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 11:46:35 -0700 (PDT)
Message-ID: <57f65fef-db65-44ce-acfb-ccc4a109280c@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 20:46:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/21] hw/pci-bridge: use stub_ss for
 pci_expander_bridge_stubs.c
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
 <20260930020108.217892-9-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260930020108.217892-9-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: vp5T2XkJlf-wyxepN14BFanCnW7GGHEI
X-Proofpoint-GUID: vp5T2XkJlf-wyxepN14BFanCnW7GGHEI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA3MyBTYWx0ZWRfX/rRKsXNMZV9B
 EM/p5+gJMVCKQflODbVL0clH36Kb06WD1voIq4sFS5AkFdzFdB7F0uGk8U6ucOUZCvCtEoZq5V3
 hWECrHwOGOErF3gr8Y8jTD/+PoIX92E=
X-Authority-Analysis: v=2.4 cv=LuEHWXdc c=1 sm=1 tr=0 ts=6ac3f08e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=VxAk22fqlfwA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA3MyBTYWx0ZWRfX5nSPjw5u9Tcp
 WOfqcCwJI0Bz/70fn2WAL7fhtsjgIgeOBNNYYTbeDF3DsSDwzHOKmTpnZ0yoknvuPfHMRdr4cvR
 BDw6EGZA/T6Hhaccggc7+EvsWpG4dtTyrXB7kWrRLbHSSz4A3breTvXrVHibzMLBtG2Xfn7AK0x
 UirwD/FEbjxXuE3cAng5DqUrBxEy5xqEHxfZ5x3BFPWZyNwBerWubNNGq+NpFxhrjKO0+4d3oKs
 qnzCoNbdt4Ddy96ksv3dA6pqf34b/CNrqKxwvCFneOe6KTABJNtsm5MhF4im3R54nuzW4fIfi6r
 UK0/HrtpsyDtkm4sw2uM6+etd8dY8Ff5cQgPg8/lC1NuFBlXbpFguY5lR+ZHWvBSafiItuzxugX
 AesaTaEWgexoOYFluC867+gWHo0VQEiEXh2R7CFkBub9tP3thOvjYw8bHPCFS1TJGZgU0rn1GlQ
 rfGO1fXy5Trc3XXnTSw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015 spamscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050073
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 30/9/26 04:00, Pierrick Bouvier wrote:
> Solve double definition error.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   hw/pci-bridge/meson.build | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

