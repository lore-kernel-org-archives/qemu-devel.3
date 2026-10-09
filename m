Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F62CA6019
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 10:07:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF7Vv-0007hw-Pj; Fri, 09 Oct 2026 06:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xF7Vu-0007dp-Ta
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 06:07:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xF7Vs-0006Ga-8p
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 06:07:41 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6998KBYs2256978
 for <qemu-devel@nongnu.org>; Fri, 9 Oct 2026 10:07:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GtyyoiOb00J0iLI3VQUp0Fo44rE+7w8JY9TyfTPgjeg=; b=hpYRKZFizraIvgL+
 4DaYUZ2j9fyIgLTaoWiFWMlZbYzVINGxInt6EmjoEry6rU3NOr9IRoGElpRSvDcW
 DXCUBS2oniA3Ub28eln/nr/4CrWKfddunYR66hjDE/emTuPdeIxj3nYzUL4SYKxx
 shqEAGWE30X7r/RtGFDDFlNh/DidxkF4xcrnfGAsXeSjaw6zgYM/Ei0ypxlnlwt3
 3+JHvr/YqdU58pk44L26dbAtcXeu85xidAIlFHUnq4o1kK9gQ0Nk4fppJccFwDTa
 ZTw420ylVncHc6zteFy4ihEeYsRieLpSqDoyhRmL1k4aGY5eN2oqVE+9dNGxbPpe
 DpinpA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6nufsuak-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 10:07:38 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e82060977so367645385a.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 03:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791540457; x=1792145257; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GtyyoiOb00J0iLI3VQUp0Fo44rE+7w8JY9TyfTPgjeg=;
 b=V7MWb92FPyjSIGyfJrFOqoomab27ZH7l4sf4beh6SxNbtMBxNeidgabTXqDs9GgiyF
 /iKbU5XFxNPPRtYqvhONz8HpMujHbhekr9BVfz4q3ZaLnclBFgTrWLfmT5PMNQcKHrKr
 CshhJB4vgUIaFGbzpYgngEt04q0VcCzWjM1C16XB8Iu9t6Gf32GAt0wT95aTtg7yXZBC
 gOUaqXu0A8ISIK/Wqom1Extdn7MLz0uJfj0gCH5/uvfEHz4pkTEE3gswCz2nbI/Cxx+N
 NWmBNde7Z1/WR834/VAjM7VkQftyzlazliuCg6IQ//cWWzgDbBXyj1uujLd4MTy1clzW
 +Dag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791540457; x=1792145257;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GtyyoiOb00J0iLI3VQUp0Fo44rE+7w8JY9TyfTPgjeg=;
 b=bW1bSs6VGcdEN+rAsE398paxWprJ06tgodz11rAoGJbps4Sn+L+Y/zU1rw5kUXUY7L
 Iil0LpOdZYTcm0AMR65C0plHyNZGuuL/VrrjtnlHn/u77YEvswP48xG/MuxdeIOTlcAL
 1iySr37GY9/SFrTUwD6LqSi/RAVUcPamGs0BsdwmXJFS2k4Nop3R79AZa/7HU4mqstQm
 XSM8T14X0cbjd0eLrnMYxVyk/d7fGlAx/KtNVYI7nkxm8cPfKMZk6naA/QKkRbChvlkL
 nbunf6MlFH8QaRh3Oxtqc6badNMD5+2DNJ4CSyr3x4NumSJVYIaGsuFWSqOlfL7zAcnX
 +srg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwifFq9SyriYeOW/53j6w16PpFi/25EbJX54k7pY92vpmmB/56jvDkzg3HA+h8Pf2M/zmelCjJ67Lno@nongnu.org
X-Gm-Message-State: AFuF++nv6tdTLlXTf59BdTqos6jRvYYe6PRmv9NB7owZJtYiepvUoe8q
 WMGLZ1opZp53/jR/uhJJGB8I7eGjoGYswJ9vuWoboqau3ybVjeFLAbiNNqgklmqraUtIqOqk3yd
 6eMXfgPrguJ3CH+KdP7WlmbHh/VPTDTdO2DBmluUyYAvv+zIs7lsCFzma1FQh8PqK+KFl
X-Gm-Gg: AYBFou1B7++Vwnt188kQO0hlWom3m2tiIOEYzUGd5TbKxTgxiz09PnFY98+N/mwBa62
 mjrUBQu40jVT/OIZZXhScBZpLv+UvglD4c9gpgmQrpVHGctianMuHYGZXdg66hCFxJwQuVDvL1x
 fPSCdHdV+JRKuuyTaDF+7J625WmJ2G2vzV01vZ16Dw31equWi7CzVmy9Z7+g6pt6FIcxN9cT91r
 LxgQnoFcW0wbfYpyzdimbZP7CuIDwxWtzkcRsevpoj4W4Vh3r8avUvxgkNoazJeVebGpAOsbNRy
 Xm/gao+RZic+6jMlD3xlZ8bPoxUB0KBunwuNH7LZZEaaDBqajEIJqXw8ScnT8TSUI4RxQFoP20d
 IG2olfapNYqCe+cbvID+jajLIUDfIc5khFA==
X-Received: by 2002:a05:620a:8810:b0:93e:787e:bd72 with SMTP id
 af79cd13be357-93eb969fafdmr253104485a.35.1791540457262; 
 Fri, 09 Oct 2026 03:07:37 -0700 (PDT)
X-Received: by 2002:a05:620a:8810:b0:93e:787e:bd72 with SMTP id
 af79cd13be357-93eb969fafdmr253100785a.35.1791540456775; 
 Fri, 09 Oct 2026 03:07:36 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9abd3aasm3136361f8f.32.2026.10.09.03.07.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2026 03:07:36 -0700 (PDT)
Message-ID: <4259329e-f503-453a-87d2-fac5da4ce3c9@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 12:07:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qga: fix typo in guest-file-read warning
Content-Language: en-US
To: =?UTF-8?Q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>,
 qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
References: <20261009-qga-file-read-typo-v1-1-40c462aefe12@proxmox.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261009-qga-file-read-typo-v1-1-40c462aefe12@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=afn0Dhot c=1 sm=1 tr=0 ts=6ac8bcea cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=Qm8iP6mkAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=kDhhxE42lZnxL3pOKqYK:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0MCBTYWx0ZWRfX5X2R7Cx3dshi
 qTdF91zxrxW1F6VgVubPDymi7KTcup/YiE2WzQqkBj2i25jIsEZw/JJagTPOsSUAxrVxnjxYrDS
 SiEghKDuAmjGaILXFi7YnsDiefVf+Ps=
X-Proofpoint-GUID: 3mhJHx8_eix-zCs9Hhf5eM0tl2VA8bNF
X-Proofpoint-ORIG-GUID: 3mhJHx8_eix-zCs9Hhf5eM0tl2VA8bNF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0MCBTYWx0ZWRfXzRF3JNihV1GP
 FqPKDQl9fALUmJD0UiFnm7xgNegnLZYaAPCXEKmNb+8ljEU92kMcWS4urblyPALFZIodLwd5+0W
 Us2C9DVod7rtPMW0GzwiWs58jP3C5ukY6IpYr8SRxBZsTVbrbCFXhA7n/Wnv6ETNAOpf8Fab7jI
 vdZQoUe+WNeM/o7zlfquGfKhl1tV+unxvueApHo2XTWybER2AETdDHGNh0UgZzzzOrHYPKcb45j
 +GyZ3ZASjXYF+5Fa/Qne91KTN7VbOZNR7cxwAJJipWWc0owfv9fz/kL2vyoRkP+2T7NZAWr0A1E
 Szb19gj7fVR56odFeUrDuoi+gTqfP5tOkfjuAbvcp6bJrsRlBnMKpMQWX9159zDAL5XoFzQiOxc
 SGkqmxJS8ayMm72AO2/zEaTy11c2pMHUShexXqVkdaWZlZKjzVZVf0niJMxcvs50KNUP2YPegts
 cOkvs0yvPN7rKAiX72g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090040
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

On 9/10/26 11:16, Fabian GrÃ¼nbichler wrote:
> seems to have been transformed from "read" to "write" during a refactor.
> 
> Fixes: ead83a136d54 "qga: Extract qmp_guest_file_read() to common commands.c"
> 
> Signed-off-by: Fabian Grünbichler <f.gruenbichler@proxmox.com>
> ---
> Stumbled upon this while browsing through the code for unrelated reasons..
> 
>   qga/commands.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

