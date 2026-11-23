Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652C760A262C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 13:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HkbTxakZ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WLrTx4NF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVUWH-0008Mq-By; Mon, 23 Nov 2026 08:55:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVUW3-0008GY-0b
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 08:55:33 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVUVz-000515-9Z
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 08:55:30 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANDL4bl2086110
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 13:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TH5JaK60/v54+uqr2pn/yczma3E+Bv7aezoxZqY9HxU=; b=HkbTxakZdsmODnX1
 JDZ2bic0+tgGVQQQae0hxlIm5XuzS50mHz9MyWDDwYeJtvKw+dnbRnmfqTOJtJYc
 UI8NsJa6jAj7z6JFt0kfWyKM9KBcJTDgWkj7hG+XDd6cOQy3aNGTN1+hFaARzujj
 VhOnn/WiLcHstCGAx+S1jAX2tXSckM/l2aycHtXkekFF6rUD2bgsiDpMBUIqU+hY
 wr7pdr0cKkyqN8Jt8oZKrgSjtQejO01hHT3wuRZfGxXh2E19UEbSgrUvswVdpi1b
 gqpgHNG3ZssWkezxNqJuvO/Y2bDBFPvJxI31t3fAiEYbZLshJd8eepD9kUxW02i9
 BXgIKg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4fy01nkf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 13:55:23 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9495dd0f07eso627595285a.0
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 05:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795442122; x=1796046922; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TH5JaK60/v54+uqr2pn/yczma3E+Bv7aezoxZqY9HxU=;
 b=WLrTx4NF1bPQrY0STA2X6Uh6ClQlQygx3jfAi1BAWAKRduR8x76jdnyLv9FcojmRRw
 B8xE4SVTTnGSvqOjnnwDV1MyW+CFrQw8ppGn8f5Bh5cTdZy/c8oNDzPQuXmDk44T4g4G
 6jRBkKuu2EazKvJzTM8J28gxt/PPO2j1iXME5ItnoTtnFTt60+l3AmbsS1W1AU0g8fo7
 Nn2aB57hOOMqtbe2xb+4yy+EvOxtqPeYc3dv9iZaEUxjrU8QuY/GT2Jl6FBLwCLNqPZd
 H5SQhyysE1HxiwYAj7edLMprDJvXGDG0MOR/+lTfFj5X6fne9whOh1eUL/BP41e46RkE
 H1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795442122; x=1796046922;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TH5JaK60/v54+uqr2pn/yczma3E+Bv7aezoxZqY9HxU=;
 b=b4uMR6EvwcIDzC1CRqvDOWsk/6iZ+W4DEaY5Afc+9EkHr1F93YqJLTplzNGcVtmy8y
 5JWb+DV18Cd3b6oU3LXH1T5CoQkEka2iWGEcu1H17oR50jcMe87TlMbzTOS/P6vvrGYU
 0yjE0ASSBY1SPhBOjMvjU/+TFmiQSeucXKfMSSUcMwXRLGSnEf/Vmv7UBJ1Zg7QNuY/z
 jSgd8l1kjgYRQa0yQbB18B0Q9IaH6oGMT2V28NqVnC1HCkQsPAAsPLrWisNKnTMVZcx+
 gLZn0kBR7aTNMGu/J3QFnsMVcrd19URP6/xlU+ret3OJrHZzmi3BmGgb3wsUkSf9bfLU
 1ofQ==
X-Forwarded-Encrypted: i=1;
 AL+hErE11XyPO9IDunzAMuqxXBs409bZcQzb78p/TJQcQgt45z3OYx7lJA3O9FSGxfnbMWuSn0Bo1+9HeiIV@nongnu.org
X-Gm-Message-State: APuU4Z+rMR7eM3GXRywC8m0VYR870ayoB6NgWoauHBprnZpmRm/c1IKk
 ewByWpmhWt8qNqeTRoNIpgzqiSy9AZOy39n8/MAV67f5MlkXAFB3IjlteI2gakN9P1S8ssPNgyH
 LdN9EAbMhcwoy1945QSMpA+MFeEuXvICvz4ldN5HZ3R9XvKmblXQfxyGbfg==
X-Gm-Gg: AZFdTZfZTGL27uSvH1SuM0diGdaTVTZMLE0KIjFEb6RGMzkD0IZtQXT8pXSnI0J/Ojd
 Z4M1faxLzElrGXsMybpYU0Yq/BboGEHp/OlAaNoYzCzGRBGANasEbn/sFaVSsbxQI17fxnSIpim
 Wm9iuB5OJlBA6f8M9Xs88/7QXY/7woxS1X62DBGpKAZrUOot5IPRjQQtfcn7hm51E4s2wPe6y7S
 At1Fg2JjrMULH1T0aWDZe0B50mVp02MMwepniPJvESuA8mcwrrrSxABuw1Mhcam7USCkaUbHuxi
 tOv9+Rv6Gad+b3LtQl/knOPjC/cJT+/dcESJgGjhuOCCoWqVBocB5ySgJVw985aLx0YIZD3o05V
 2Y5MbQl1tUMTwwzfS3D4CO19JzRqx2NosTwUGoGFxmu4rFp5aybgxXg2ttAmSIZ5V356CK6Y6rY
 Ss9DTRAhA=
X-Received: by 2002:a05:620a:63ca:b0:93f:3bb5:5452 with SMTP id
 af79cd13be357-949ba99c7d9mr1891014985a.15.1795442122415; 
 Mon, 23 Nov 2026 05:55:22 -0800 (PST)
X-Received: by 2002:a05:620a:63ca:b0:93f:3bb5:5452 with SMTP id
 af79cd13be357-949ba99c7d9mr1891009485a.15.1795442121857; 
 Mon, 23 Nov 2026 05:55:21 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb9066e34esm193949505e9.3.2026.11.23.05.55.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 05:55:21 -0800 (PST)
Message-ID: <baef72f0-5ecf-400e-addf-7059391ba45c@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 14:55:20 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/nvme: fix use-after-free on duplicate dbbuf
 configuration
Content-Language: en-US
To: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 Keith Busch <kbusch@kernel.org>, Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>
References: <20261123-fix-4902-v1-1-342b8dc00fef@samsung.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261123-fix-4902-v1-1-342b8dc00fef@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1NSBTYWx0ZWRfXwhOekWBoZQjo
 7ZoBiY5zDU2LYsaN/NoypLDbgViags1GgNhN2612JyLFMr9ViH3SNDExE/ptVH3+PhEc8ivbgML
 VTI4QQ8AFQpl27TPFh8NzsfD+32FYKEuCuCRXqc7qxaTadm0o0wPdxQTiv2XE0hWX5BwODjXonP
 5hLuJUEz80LKPpUH/y9r5nXiExR81r8JgMDFZ5WSRx2VnELwt6hczcu0GX+4DLhB7prLipWna+9
 15al5Tie2YNO7naOyusO/Q0CV4LxFrz0X3KjWDdeJFx+yeS24EmkFZaxn3Z9yKvthgve6IE/chg
 VRnL8Hx66S4HhEwmgNLgRzRaSvcLmK1R9jYaTz0vdI743q1CHLNP87Wv5lLtmbmjAes2GgSMQsa
 J/Hbif6286eGr6A/jByCSVEDjRI9PaaijAQPrfV++y1FLnTNaOoprZUdFqIQ82OBON6Yo16er47
 W8ckItChEAwDZ1LM5vA==
X-Proofpoint-ORIG-GUID: btDYdTduB2OCcIPOT-LwUzdU4IMnuA0a
X-Authority-Analysis: v=2.4 cv=QrXLTlyd c=1 sm=1 tr=0 ts=6b0445cb cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=p0WdMEafAAAA:8 a=hD80L64hAAAA:8 a=EUspDBNiAAAA:8 a=-RGDDannhxDs1ZJ8-q4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: btDYdTduB2OCcIPOT-LwUzdU4IMnuA0a
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1NSBTYWx0ZWRfX9HhISZTTGdEk
 8+2WEH7PHfJMue580FlWY/SvEcMXaQ7cxOS0+gIRE3JW/Cr8rGR3nS34zgjlZr0B3Y4wNVqxhnS
 OZvP2rZqqnpgKKkj6Wdov6lOz3TPLBs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230055
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 23/11/26 11:03, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> nvme_cq_init_notifier and nvme_sq_init_notifier does not consider that
> the notifiers may already have been initialized. A second Doorbell
> Buffer Config command will re-initialized the notifiers and leak the
> previous fds. The leaked fd will remain registered on the doorbell
> address and may be dispatched on doorbell writes, referencing freed
> memory.
> 
> Make sure the notifiers are not initialized more than once.
> 
> Link: https://gitlab.com/qemu-project/qemu/-/work_items/4520
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4902
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>   hw/nvme/ctrl.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 5755aad1fa72..7b5f6178dd36 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -4837,6 +4837,10 @@ static int nvme_init_cq_ioeventfd(NvmeCQueue *cq)
>       uint16_t offset = (cq->cqid << 3) + (1 << 2);
>       int ret;
>   
> +    if (cq->notifier.initialized) {
> +        return 0;

Simple enough; but avoid poking EventNotifier internals:

--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ static int nvme_init_cq_ioeventfd(NvmeCQueue *cq)
-    if (cq->notifier.initialized) {
+    if (event_notifier_initialized(&cq->notifier)) {
          return 0;
      }

@@ static int nvme_init_sq_ioeventfd(NvmeSQueue *sq)
-    if (sq->notifier.initialized) {
+    if (event_notifier_initialized(&sq->notifier)) {
          return 0;
      }

With that:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Alternatively guard the registration state that actually causes the
dangling ioeventfd, checking ioeventfd_enabled at the DBC call sites:

@@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, const NvmeRequest *req)
-            if (n->params.ioeventfd && sq->sqid != 0) {
+            if (n->params.ioeventfd && sq->sqid != 0 &&
+                !sq->ioeventfd_enabled) {
                  if (!nvme_init_sq_ioeventfd(sq)) {
                      sq->ioeventfd_enabled = true;
                  }
              }

@@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, const NvmeRequest *req)
-            if (n->params.ioeventfd && cq->cqid != 0) {
+            if (n->params.ioeventfd && cq->cqid != 0 &&
+                !cq->ioeventfd_enabled) {
                  if (!nvme_init_cq_ioeventfd(cq)) {
                      cq->ioeventfd_enabled = true;
                  }
              }


